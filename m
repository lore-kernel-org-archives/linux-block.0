Return-Path: <markus@trippelsdorf.de>
Date: Sat, 6 May 2017 07:15:27 +0200
From: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 cosmetic] Remove trailing newline in elevator switch
 error message
Message-ID: <20170506051527.GA291@x4>
References: <20170429053808.GA293@x4>
 <1493651927.2665.3.camel@sandisk.com>
 <20170501154958.GA291@x4>
 <1493654279.2665.5.camel@sandisk.com>
 <20170501162928.GB291@x4>
 <1494014718.2744.20.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494014718.2744.20.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On 2017.05.05 at 20:05 +0000, Bart Van Assche wrote:
> On Mon, 2017-05-01 at 18:29 +0200, markus@trippelsdorf.de wrote:
> > +	strlcpy(elevator_name, name, sizeof(elevator_name));
> > +	strstrip(elevator_name);
> > +	ret = __elevator_change(q, elevator_name);
> 
> 
> Are you aware that the current implementation of __elevator_change() strips
> leading whitespace but that with your patch applied leading whitespace is no
> longer removed from the elevator name? If you have a look at strim() in
> lib/string.c you will see that in case of leading whitespace that function
> does not remove the leading whitespace but returns a pointer to the first
> non-whitespace character.

Well, only in the call to elevator_get(). The dmesg output does contain
leading whitespace. But the fix is simple. I will send a new patch.

-- 
Markus
