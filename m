Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Factor out req_set_nomerge
To: Ritesh Harjani <riteshh@codeaurora.org>
References: <1480588058-29998-1-git-send-email-riteshh@codeaurora.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5db68671-c5ba-26d1-c9be-7e85cedc0b4c@kernel.dk>
Date: Thu, 1 Dec 2016 08:38:02 -0700
MIME-Version: 1.0
In-Reply-To: <1480588058-29998-1-git-send-email-riteshh@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/01/2016 03:27 AM, Ritesh Harjani wrote:
> Factor out common code for setting REQ_NOMERGE
> flag which is being used out at certain places
> and make it a helper instead (req_set_nomerge).

I applied this, but I got rid of the inline. Let the compiler do it's
job, if anything this should be marked out-of-line, since it's not a hot
path.

Beware that your email triggers the gmail spam filter, since it's
failing the authenticity check. You might want to look into that.

-- 
Jens Axboe
