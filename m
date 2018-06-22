Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: Change simple_strtol() to kstrtol()
To: Kitone Elvis Peter <elviskitone@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <58db0446-1e25-d2ba-3d47-33d5e19beecc@kernel.dk>
Date: Fri, 22 Jun 2018 13:51:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 5:39 AM, Kitone Elvis Peter wrote:
> The usage of simple_strtol is discouraged, because
> strtol() is obsolete. Instead kstrtol() should be 
> used to convert a string into a long integer.

My patience is running pretty thin with you. Don't send untested
crap, you haven't even compiled this.

-- 
Jens Axboe
