Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
Date: Mon, 8 May 2017 15:47:59 +0000
Message-ID: <1494258478.2591.7.camel@sandisk.com>
References: <20170506052243.GB291@x4>
In-Reply-To: <20170506052243.GB291@x4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-05-06 at 07:22 +0200, markus@trippelsdorf.de wrote:
> -	ret =3D __elevator_change(q, name);
> +	strlcpy(elevator_name, skip_spaces(name), sizeof(elevator_name));

Hello Markus,

Please include the version number of a patch in the e-mail subject line whe=
n
posting a second or later version. Regarding the strlcpy() call, in the
FreeBSD strlcpy() man page I found the following: "If the src and dst strin=
gs
overlap, the behavior is undefined." Since the Linux kernel implementation =
of
strlcpy() uses memcpy() and since the ANSI C standard does not allow that
memcpy() input and output buffers overlap, please rework this code. See e.g=
.
http://pubs.opengroup.org/onlinepubs/9699919799/functions/memcpy.html

Thanks,

Bart.=
