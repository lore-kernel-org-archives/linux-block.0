Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        ming.lei@redhat.com, tytso@mit.edu, darrick.wong@oracle.com,
        jikos@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-fsdevel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, todd.e.brandt@linux.intel.com, nborisov@suse.com,
        jack@suse.cz, martin.petersen@oracle.com, ONeukum@suse.com,
        oleksandr@natalenko.name, oleg.b.antonyan@gmail.com,
        linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] pm: remove kernel thread freezing
Date: Tue, 03 Oct 2017 20:59:00 +0200
Message-ID: <1862632.MOTT9GD8nq@aspire.rjw.lan>
In-Reply-To: <20171003185313.1017-6-mcgrof@kernel.org>
References: <20171003185313.1017-1-mcgrof@kernel.org> <20171003185313.1017-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tuesday, October 3, 2017 8:53:13 PM CEST Luis R. Rodriguez wrote:
> Now that all filesystems which used to rely on kthread
> freezing have been converted to filesystem freeze/thawing
> we can remove the kernel kthread freezer.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

I like this one. :-)

Thanks,
Rafael
