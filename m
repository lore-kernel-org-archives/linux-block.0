Return-Path: <viro@ftp.linux.org.uk>
Date: Thu, 15 Jun 2017 12:24:20 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca, hch@infradead.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170615112420.GN31671@ZenIV.linux.org.uk>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615041503.GB4521@birch.djwong.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 09:15:03PM -0700, Darrick J. Wong wrote:
> > + */
> > +#define RWF_WRITE_LIFE_SHIFT		4
> > +#define RWF_WRITE_LIFE_MASK		0x000000f0 /* 4 bits of stream ID */
> > +#define RWF_WRITE_LIFE_SHORT		(1 << RWF_WRITE_LIFE_SHIFT)
> > +#define RWF_WRITE_LIFE_MEDIUM		(2 << RWF_WRITE_LIFE_SHIFT)
> > +#define RWF_WRITE_LIFE_LONG		(3 << RWF_WRITE_LIFE_SHIFT)
> > +#define RWF_WRITE_LIFE_EXTREME		(4 << RWF_WRITE_LIFE_SHIFT)
> 
> Should O_TMPFILE files ought to be created with i_write_hint =
> RWF_WRITE_LIFE_SHORT by default?

Depends...  One of the uses for that is to have them linked into permanent
place once completely written...
