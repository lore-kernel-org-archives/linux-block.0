Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 15:59:30 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        ming.lei@redhat.com, darrick.wong@oracle.com, jikos@kernel.org,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-fsdevel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, todd.e.brandt@linux.intel.com, nborisov@suse.com,
        jack@suse.cz, martin.petersen@oracle.com, ONeukum@suse.com,
        oleksandr@natalenko.name, oleg.b.antonyan@gmail.com,
        linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/5] ext4: add fs freezing support on suspend/hibernation
Message-ID: <20171003195930.ivgaccdabxczar62@thunk.org>
References: <20171003185313.1017-1-mcgrof@kernel.org>
 <20171003185313.1017-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003185313.1017-5-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 03, 2017 at 11:53:12AM -0700, Luis R. Rodriguez wrote:
> @@ -4926,7 +4926,7 @@ static int ext4_unfreeze(struct super_block *sb)
>  		ext4_set_feature_journal_needs_recovery(sb);
>  	}
>  
> -	ext4_commit_super(sb, 1);
> +	ext4_commit_super(sb, 0);
>  	return 0;
>  }
>

After we remove add the NEEDS_RECOVERY flag, we need to make sure
recovery flag is pushed out to disk before any other changes are
allowed to be pushed out to disk.  That's why we originally did the
update synchronously.

There are other ways we could fulfill this requirements, but doing a
synchronous update is the simplest way to handle this.  Was it
necessary to change this given the other changes you are making the fs
freeze implementation?

					- Ted
