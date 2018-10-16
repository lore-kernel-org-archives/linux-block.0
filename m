Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Tue, 16 Oct 2018 14:25:13 -0400
From: Dennis Zhou <dennis@kernel.org>
To: valdis.kletnieks@vt.edu
Cc: Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 16, 2018 at 12:02:03PM -0400, Dennis Zhou wrote:
> Hi Vladis,
> 
> On Mon, Oct 15, 2018 at 07:28:48PM -0400, valdis.kletnieks@vt.edu wrote:
> > So I finally had a chance to find a replicator and finish bisecting this and:
> > 
> > [/usr/src/linux-next] git bisect good
> > e2b0989954ae7c80609f77e7ce203bea6d2c54e1 is the first bad commit
> > commit e2b0989954ae7c80609f77e7ce203bea6d2c54e1
> > Author: Dennis Zhou (Facebook) <dennisszhou@gmail.com>
> > Date:   Tue Sep 11 14:41:35 2018 -0400
> > 
> >     blkcg: cleanup and make blk_get_rl use blkg_lookup_create
> > 
> > I was able to do a bit of sleuthing with strace, and I tracked it down to one of
> > several execve() calls that 'rpm' makes with my replicating test case.
> > 
> >  grep execve /root/rpm-exec-strace 
> > execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
> > [pid 119212] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.w7fu"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119213] execve("/sbin/ldconfig", ["/sbin/ldconfig"], 0x558ccf928ac0 /* 33 vars */) = 0
> > [pid 119216] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.bIKt"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119217] execve("/usr/bin/systemd-run", ["/usr/bin/systemd-run", "/usr/bin/systemctl", "start", "man-db-cache-update"], 0x56360645d290 /* 33 vars */) = 0
> > [pid 119221] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.OGWg"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119920] execve("/usr/bin/systemctl", ["/usr/bin/systemctl", "daemon-reload"], 0x55c0f5d43c30 /* 33 vars */) = 0
> > 
> > The ldconfig and systemctl commands run just fine stand-alone, so I'm suspecting the
> > calls to run the temp files - it's quite possible that execve() gets invoked on them before
> > writeback has actually gotten the data to the disk - though that shouldn't matter.
> > 
> > But I managed to trigger a different traceback. I cd /usr/src/redhat/tmp, and I
> > did an 'rm *' - and never got a prompt back. Traceback out of pstore below.
> > 
> > Now here's the weird part - I'd already unmounted, fsck'ed, and remounted the
> > file system before the 'rm *'.  And thinking that there was one file with a
> > busted inode that passed fsck.ext4's sniff test, I did:
> > 
> > cd /usr/src/redhat/tmp
> > for i in `find . -type f`; do sleep 5; echo $i; rm $i; done
> > 
> > and that worked just fine. Nothing left in that directory but . and ..  
> > I then re-ran my rpm-based replicator and it blew up again.
> > 
> > Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
> > as none of the tmpfile config reference /usr/src at all, and the config says it
> > shouldn't have been running at the time of the crash, and I can't replicate as
> > the directory is now empty...)
> > 
> 
> Thanks for testing and reporting this! Do you mind sending me your
> reproducer?
> 
> Thanks,
> Dennis

I've spent some time thinking about this, and this is my guess at what
is happening without seeing your reproducer. The system is under memory
pressure and a new cgroup is being created. The cgroup allocation fails
causing the request_list code to fallback and walk up the blkg tree.
There is special handling for the root cgroup, but I missed that case
and it fails there I believe.

In addition to sending me the reproducer and your config, can you please
try the patch below?

Thanks,
Dennis

---
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b7fd08013de2..1e76ceebeb5d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -597,7 +597,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		blkg = __blkg_lookup_create(blkcg, q);
 
-	if (!blkg_tryget(blkg))
+	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
 		goto rl_use_root;
 
 	rcu_read_unlock();
