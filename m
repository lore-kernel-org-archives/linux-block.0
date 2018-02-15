Return-Path: <joe@perches.com>
Message-ID: <1518661577.3678.44.camel@perches.com>
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
From: Joe Perches <joe@perches.com>
To: Al Viro <viro@ZenIV.linux.org.uk>, John Pittman <jpittman@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2018 18:26:17 -0800
In-Reply-To: <20180215021321.GB30522@ZenIV.linux.org.uk>
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
	 <20180215021321.GB30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-02-15 at 02:13 +0000, Al Viro wrote:
> On Wed, Feb 14, 2018 at 08:37:02PM -0500, John Pittman wrote:
> > In quite a few files throughout the block layer, the bare 'unsigned' is
> > used rather than the preferred 'unsigned int'.
> 
> Preferred by whom?

The kernel as a whole, ~12:1

> >  The issue was
> 
> What is that "issue" and why is it a problem in the first place?

it's not.

> Oh, good - so presumably it does have some explanations beyond "The Most Holy
> checkpatch.pl Spake Unto Us"; could the esteemed sir share those with us?

infidel...

;)
