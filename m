Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: Should a raid-0 array immediately stop if a component disk is
 removed?
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-raid@vger.kernel.org
References: <301f2a37-81ea-938b-3bd1-947f716c0f63@canonical.com>
From: Wols Lists <antlists@youngman.org.uk>
Message-ID: <5AE3A00B.6050801@youngman.org.uk>
Date: Fri, 27 Apr 2018 23:11:23 +0100
MIME-Version: 1.0
In-Reply-To: <301f2a37-81ea-938b-3bd1-947f716c0f63@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, kernel@gpiccoli.net,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 27/04/18 22:49, Guilherme G. Piccoli wrote:
> Hello, we've noticed an interesting behavior when using a raid-0 md
> array. Suppose we have a 2-disk raid-0 array that has a mount point
> set - in our tests, we've used ext4 filesystem. If we remove one of
> the component disks via sysfs[0], userspace is notified, but mdadm tool
> fails to stop the array[1] (it cannot open the array device node with
> O_EXCL flag, hence it fails to issue the STOP_ARRAY ioctl). Even if we
> circumvent the mdadm O_EXCL open, md driver will fail to execute the
> ioctl given the array is mounted.

Sounds like you're not using mdadm to remove the disk. So why do you
expect mdadm to stop the array immediately? It doesn't know anything is
wrong until it trips over the missing disk.
> 
> As a result, the array keeps mounted and we can even read/write from
> it, although it's possible to observe filesystem errors on dmesg[2].
> Eventually, after some _minutes_, the filesystem gets remounted as
> read-only.

Is your array linear or striped? If it's striped, I would expect it to
fall over in a heap very quickly. If it's linear, it depends whether you
remove drive 0 or drive 1. If you remove drive 0, it will fall over very
quickly. If you remove drive 1, the fuller your array the quicker it
will fall over (if your array isn't very full, drive 1 may well not be
used in which case the array might not fall over at all!)
> 
> During this weird window in which the array had a component disk removed
> but is still mounted/active (and accepting read/writes), we tried to
> perform reads and writes and sync command, which "succeed" (meaning the
> commands themselves didn't fail, although the errors were observed in
> dmesg). When "dd" was executed with "oflag=direct", the writes failed
> immediately. This was observed with both nvme and scsi disks composing
> the raid-0 array.
> 
> We've started to pursue a solution to this, which seems to be an odd
> behavior. But worth to check in the CC'ed lists if perhaps this is "by
> design" or if it was already discussed in the past (maybe an idea was
> proposed). Tests were executed with v4.17-rc2 and upstream mdadm tool.

Note that raid-0 is NOT redundant. Standard advice is "if a drive fails,
expect to lose your data". So the fact that your array limps on should
be the pleasant surprise, not that it blows up in ways you didn't expect.
> 
> Thanks in advance,
> 
> 
> Guilherme

Cheers,
Wol


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
