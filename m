Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] block: remove the paride drivers
Date: Thu, 15 Mar 2018 09:04:24 +0100
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180315075256.25652-1-hch@lst.de>
In-Reply-To: <20180315075256.25652-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201803150904.25087.linux@rainbow-software.org>
List-ID: <linux-block@vger.kernel.org>

On Thursday 15 March 2018, Christoph Hellwig wrote:
> The paride drivers are some of the cruftiest, grottiest block drivers
> (besides drivers/ide and floppy.c) and have seen one single targeted
> commit since the dawn of git in 2007.  Drop them to make block layer
> improvements easier.

This will make my parallel port ZIP and LS-120 drives useless :(

-- 
Ondrej Zary
