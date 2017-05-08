Return-Path: <markus@trippelsdorf.de>
Date: Mon, 8 May 2017 18:48:36 +0200
From: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
Message-ID: <20170508164836.GA17152@x4>
References: <20170506052243.GB291@x4>
 <1494258478.2591.7.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494258478.2591.7.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On 2017.05.08 at 15:47 +0000, Bart Van Assche wrote:
> On Sat, 2017-05-06 at 07:22 +0200, markus@trippelsdorf.de wrote:
> > -	ret = __elevator_change(q, name);
> > +	strlcpy(elevator_name, skip_spaces(name), sizeof(elevator_name));
> 
> Please include the version number of a patch in the e-mail subject line when
> posting a second or later version. Regarding the strlcpy() call, in the
> FreeBSD strlcpy() man page I found the following: "If the src and dst strings
> overlap, the behavior is undefined." Since the Linux kernel implementation of
> strlcpy() uses memcpy() and since the ANSI C standard does not allow that
> memcpy() input and output buffers overlap, please rework this code. See e.g.
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/memcpy.html

I don't see how src and dst could possibly overlap here.

-- 
Markus
