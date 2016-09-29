Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Sep 2016 10:48:34 +0200
From: "tj@kernel.org" <tj@kernel.org>
To: Adam Manzanares <Adam.Manzanares@hgst.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enabling ATA Command Priorities
Message-ID: <20160929084834.GD11087@mtj.duckdns.org>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <20160928020610.GA28998@infradead.org>
 <5C8FF242-7C7B-442E-A6FF-89878366F154@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5C8FF242-7C7B-442E-A6FF-89878366F154@hgst.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Sep 28, 2016 at 03:43:32AM +0000, Adam Manzanares wrote:
> I prefer having the feature conditional so you can use the CFQ
> scheduler with I/O priorities as is. If you decide to enable the
> feature then the priorities will be passed down to the drive in
> addition to the work that the CFQ scheduler does. Since this feature
> may change the user perceived performance of the device I want to
> make sure they know what they are getting into.

Yeah, I prefer to have it behind an explicit flag given the history of
optional ATA features.  The feature is unlikely to matter to a lot of
people and is almost bound to break existing RT prio usages.

Thanks.

-- 
tejun
