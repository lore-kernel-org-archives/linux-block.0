Return-Path: <viro@ftp.linux.org.uk>
Date: Thu, 15 Feb 2018 02:13:21 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Pittman <jpittman@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
Message-ID: <20180215021321.GB30522@ZenIV.linux.org.uk>
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 14, 2018 at 08:37:02PM -0500, John Pittman wrote:
> In quite a few files throughout the block layer, the bare 'unsigned' is
> used rather than the preferred 'unsigned int'.

Preferred by whom?

>  The issue was

What is that "issue" and why is it a problem in the first place?

> exposed by checkpatch.pl.  Warnings encountered were:

Oh, good - so presumably it does have some explanations beyond "The Most Holy
checkpatch.pl Spake Unto Us"; could the esteemed sir share those with us?
