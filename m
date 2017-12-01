Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Message-ID: <1512155144.4322.13.camel@redhat.com>
Subject: Re: [PATCH 00/11] fs: use freeze_fs on suspend/hibernate
From: Jeff Layton <jlayton@redhat.com>
To: Jiri Kosina <jikos@kernel.org>, Yu Chen <yu.chen.surf@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        bart.vanassche@wdc.com, ming.lei@redhat.com, tytso@mit.edu,
        darrick.wong@oracle.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-fsdevel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, todd.e.brandt@linux.intel.com, nborisov@suse.com,
        jack@suse.cz, martin.petersen@oracle.com, ONeukum@suse.com,
        oleksandr@natalenko.name, oleg.b.antonyan@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Date: Fri, 01 Dec 2017 14:05:44 -0500
In-Reply-To: <nycvar.YFH.7.76.1711301740000.11505@cbobk.fhfr.pm>
References: <20171129232356.28296-1-mcgrof@kernel.org>
         <CADjb_WRG8hxJB3zY5_XnZqeQbCy3jYW5xJaS63_7FGztZymLzg@mail.gmail.com>
         <nycvar.YFH.7.76.1711301740000.11505@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-11-30 at 17:41 +0100, Jiri Kosina wrote:
> On Fri, 1 Dec 2017, Yu Chen wrote:
> 
> > BTW, is nfs able to be included in this set? I also encountered a 
> > freeze() failure due to nfs access during that stage recently.
> 
> The freezer usage in NFS is magnitudes more complicated, so it makes sense 
> to first go after the lower hanging fruit to figure out the viability of 
> the whole aproach in practice.
> 

Agreed that we should do this in stages. It doesn't help that freezer
handling in the client is a bit of a mess at this point...

At a high level for NFS, I think we need to have freeze_fs make the RPC
engine "park" newly issued RPCs for that fs' client onto a
rpc_wait_queue. Any RPC that has already been sent however, we need to
wait for a reply.

Once everything is quiesced we can return and call it frozen.
unfreeze_fs can then just have the engine stop parking RPCs and wake up
the waitq.

That should be enough to make suspend and resume work more reliably. If,
however, you're interested in making the cgroup freezer also work, then
we may need to do a bit more work to ensure that we don't end up with
frozen tasks squatting on VFS locks.
-- 
Jeff Layton <jlayton@redhat.com>
