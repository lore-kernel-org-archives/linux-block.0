Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove remnant refs to hardsect
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org
References: <1473856372-22204-1-git-send-email-linus.walleij@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4911dca-b840-997f-c4e4-2d4dab9d6d92@kernel.dk>
Date: Wed, 14 Sep 2016 08:45:26 -0600
MIME-Version: 1.0
In-Reply-To: <1473856372-22204-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 06:32 AM, Linus Walleij wrote:
> commit e1defc4ff0cf57aca6c5e3ff99fa503f5943c1f1
> "block: Do away with the notion of hardsect_size"
> removed the notion of "hardware sector size" from
> the kernel in favor of logical block size, but
> references remain in comments and documentation.
>
> Update the remaining sites mentioning hardsect.

Added for 4.9, thanks.

-- 
Jens Axboe
