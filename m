Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 cosmetic] Remove trailing newline in elevator switch
 error message
Date: Fri, 5 May 2017 20:05:20 +0000
Message-ID: <1494014718.2744.20.camel@sandisk.com>
References: <20170429053808.GA293@x4> <1493651927.2665.3.camel@sandisk.com>
	 <20170501154958.GA291@x4> <1493654279.2665.5.camel@sandisk.com>
	 <20170501162928.GB291@x4>
In-Reply-To: <20170501162928.GB291@x4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-05-01 at 18:29 +0200, markus@trippelsdorf.de wrote:
> +	strlcpy(elevator_name, name, sizeof(elevator_name));
> +	strstrip(elevator_name);
> +	ret =3D __elevator_change(q, elevator_name);

Hello Markus,

Are you aware that the current implementation of __elevator_change() strips
leading whitespace but that with your patch applied leading whitespace is n=
o
longer removed from the elevator name? If you have a look at strim() in
lib/string.c you will see that in case of leading whitespace that function
does not remove the leading whitespace but returns a pointer to the first
non-whitespace character.

Otherwise this patch looks fine to  me.

Bart.=
