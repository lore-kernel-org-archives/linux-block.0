Return-Path: <hch@lst.de>
Date: Sat, 26 May 2018 14:21:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Popuri, Sriram" <Sriram.Popuri@netapp.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Knight, Frederick" <Frederick.Knight@netapp.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] nvme: use the changed namespaces list log to
	clear ns data changed AENs
Message-ID: <20180526122137.GA21257@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-14-hch@lst.de> <BN7PR06MB403359D8914D0A17425C037E92680@BN7PR06MB4033.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BN7PR06MB403359D8914D0A17425C037E92680@BN7PR06MB4033.namprd06.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, May 26, 2018 at 12:05:02PM +0000, Popuri, Sriram wrote:
> Reading the spec it looks like ns log is alternate approach:
> 
> "Namespace Attribute Changed: The Identify Namespace data structure for one or more namespaces, as well as the Namespace List returned when the Identify command is issued with the CNS field set to 02h, have changed. Host software may use this event as an indication that it should read the Identify Namespace data structures for each namespace to determine what has changed.
> 
> Alternatively, host software may request the Changed Namespace List (Log Identifier 04h) to determine which namespaces in this controller have changed Identify Namespace information since the last time the log page was read."
> 
> My question is: Does the target needs to implement log page 04h as this is an optional log page and the text above suggests its used in alternate way?

Section 5.2 clearly states that each AER comes with a log page to
clear it, and the above does not contain any language to explicitly
override it. So my reading of the spec is that to clear the event you need
to read the log page, but to find out what has changed you might issue
Identify commands instead.

> If target is not required to implement, then I guess your change should still work because if log page 04h fails, it fails back to rescan. Correct?

Independ of what the spec actually requires, the code tries to robust
as possible and falls back to doing the manual scan.

> I think you can optimize this by checking the "Log Page Identifier" field in your result and accordingly setting EVENT_NS_CHANGED. I assume target would clear this if log page 04h is not supported.

We can try that, but I'm not sure what it is going to buy us.
