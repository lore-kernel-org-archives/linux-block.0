Return-Path: <prvs=32061165df=axboe@fb.com>
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Josef Bacik <jbacik@fb.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
References: <1485983500-3830-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <4f619d6e-f198-dee2-230b-19fb65c045b9@fb.com>
Date: Wed, 1 Feb 2017 17:36:15 -0800
MIME-Version: 1.0
In-Reply-To: <1485983500-3830-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 01:11 PM, Josef Bacik wrote:
> To prepare for dynamically adding new nbd devices to the system switch
> from using an array for the nbd devices and instead use an idr.  This
> copies what loop does for keeping track of its devices.

Applied for 4.11, thanks.

-- 
Jens Axboe
