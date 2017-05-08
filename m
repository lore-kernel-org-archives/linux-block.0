Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20170506052243.GB291@x4>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9ce85ce-b489-9f61-2912-3e686d75d6dc@kernel.dk>
Date: Mon, 8 May 2017 10:53:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170506052243.GB291@x4>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/05/2017 11:22 PM, markus@trippelsdorf.de wrote:
> 
> Trying to switch to a non-existing elevator currently results in garbled
> dmesg output, e.g.:
> 
>  # echo "  foo" > /sys/block/sda/queue/scheduler 
> 
> elevator: type   foo not found
> elevator: switch to   foo
>  failed
> 
> (note the leading whitespace and unintended line break.)
> 
> Fix by removing the leading whitespace and stripping the trailing newline.

Added, thanks.

-- 
Jens Axboe
