Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dave Chinner <david@fromorbit.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jan Kara <jack@suse.cz>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bart.vanassche@wdc.com,
        ming.lei@redhat.com, Ted Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jiri Kosina <jikos@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-fsdevel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>, nborisov@suse.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Oliver Neukum <ONeukum@suse.com>, oleksandr@natalenko.name,
        Oleg Antonyan <oleg.b.antonyan@gmail.com>,
        Yu Chen <yu.chen.surf@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/11] xfs: remove not needed freezing calls
Date: Fri, 01 Dec 2017 00:40:31 +0100
Message-ID: <28033585.qtnqnMzzMp@aspire.rjw.lan>
In-Reply-To: <20171130233033.GO5858@dastard>
References: <20171129232356.28296-1-mcgrof@kernel.org> <CAJZ5v0hrEWOMi+C0Cw+ij_P7fwh=d7KVHAKWWTc=C2SSw=2nkA@mail.gmail.com> <20171130233033.GO5858@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Friday, December 1, 2017 12:30:33 AM CET Dave Chinner wrote:
> On Thu, Nov 30, 2017 at 09:32:53PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 30, 2017 at 5:21 PM, Jan Kara <jack@suse.cz> wrote:
> > > On Wed 29-11-17 15:23:52, Luis R. Rodriguez wrote:
> > >> This removes superflous freezer calls as they are no longer needed
> > >> as the VFS now performs filesystem freezing/thaw if the filesystem has
> > >> support for it.
> > >>
> > >> The following Coccinelle rule was used as follows:
> > >>
> > >> spatch --sp-file fs-freeze-cleanup.cocci --in-place fs/$FS/
> > >
> > > I think your rule misses WQ_FREEZABLE flag for workqueues? That would be
> > > also good to get rid of...
> > 
> > We need that one (or equivalent) for the runtime PM workqueue at least.
> 
> I think Jan was talking about all the WQ_FREEZABLE flags in
> filesystem workqueues (such as all the XFS wqs) that are no longer
> necessary once filesystems are frozen appropriately.

I see, thanks.  That was unclear to me, sorry for the confusion.

Thanks,
Rafael
