Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 17 Nov 2016 07:38:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v1 2/7] lib: Add Sed-opal library
Message-ID: <20161117153811.GA16761@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com,
 Rafael.Antognolli@intel.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

I'm trying to understand the logic for how the OPAL state machine
and how it interacts with the Security Send / Receive commands.

It seems like it's implemented as an asynchronous state machine,
but all the callers and up waiting synchronously for the result.

How about making ->send and ->recv (or the merged method if you
follow my earlier suggestion) synchronous, e.g. for nvme just
switch from blk_execute_rq_nowait to blk_execute_rq for the
execution and stop passing the cb and cb_data arguments which
would not be needed with this scheme.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
