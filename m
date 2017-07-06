Return-Path: <tang.junhui@zte.com.cn>
In-Reply-To: <20170705182645.GD10673@infradead.org>
References: <20170629134510.GA32385@infradead.org> <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net> <1498855388-16990-5-git-send-email-bcache@lists.ewheeler.net> <20170705182645.GD10673@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, bcache@lists.ewheeler.net, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org,
        Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
Subject: Re: Re: [PATCH 05/19] bcache: fix calling ida_simple_remove() with
 incorrect minor
Message-ID: <OF9C0AB33E.DE69B617-ON48258155.0022B9D3-48258155.0022DE3C@zte.com.cn>
From: tang.junhui@zte.com.cn
Date: Thu, 6 Jul 2017 14:21:05 +0800
Content-Type: multipart/alternative; boundary="=_alternative 0022DE3C48258155_="
List-ID: <linux-block@vger.kernel.org>

This is a multipart message in MIME format.
--=_alternative 0022DE3C48258155_=
Content-Type: text/plain; charset="US-ASCII"

Hello Christoph

> > +#define BCACHE_TO_IDA_MINORS(first_minor) ((first_minor) >> 
BCACHE_MINORS_BITS)
> > +#define IDA_TO_BCACHE_MINORS(minor)       ((minor) << 
BCACHE_MINORS_BITS)
> 
> Please use inline functions and lower case for these.

I have send you a v2 patch, please have a review again.

Thanks
Tang Junhui
--=_alternative 0022DE3C48258155_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello Christoph</font>
<br>
<br><tt><font size=2>&gt; &gt; +#define BCACHE_TO_IDA_MINORS(first_minor)
((first_minor) &gt;&gt; BCACHE_MINORS_BITS)<br>
&gt; &gt; +#define IDA_TO_BCACHE_MINORS(minor) &nbsp; &nbsp; &nbsp; ((minor)
&lt;&lt; BCACHE_MINORS_BITS)<br>
&gt; <br>
&gt; Please use inline functions and lower case for these.</font></tt>
<br>
<br><font size=2 face="sans-serif">I have send you a v2 patch, please have
a review again.</font>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Tang Junhui</font>
--=_alternative 0022DE3C48258155_=--
