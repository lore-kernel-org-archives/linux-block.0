Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] bcache: add separate workqueue for journal_write to
 avoid deadlock
To: =?UTF-8?B?5Zu954Ks5pa5?= <fangguoju@gmail.com>
Cc: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20180927154146.28262-1-colyli@suse.de>
 <20180927154146.28262-2-colyli@suse.de>
 <970bb505-ef6e-7057-5e0f-21d9439b4031@kernel.dk>
 <CAB1iPWn1kYVDMdSFJC6BgzKRP781ijzW5c-m93LsQuzQofeOTQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <20fee655-d18d-c931-a910-f8965bda71e0@kernel.dk>
Date: Thu, 27 Sep 2018 10:06:35 -0600
MIME-Version: 1.0
In-Reply-To: <CAB1iPWn1kYVDMdSFJC6BgzKRP781ijzW5c-m93LsQuzQofeOTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/27/18 9:57 AM, 国炬方 wrote:
> Yes, Guoju Fang. Thx. :)

OK, I made that change and committed it. Just be sure to use your full
name in the future for signoffs, etc.

-- 
Jens Axboe
