Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45362 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcEHJBt (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 8 May 2016 05:01:49 -0400
Date: Sun, 8 May 2016 02:01:48 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"boaz@plexistor.com" <boaz@plexistor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
	"xfs@oss.sgi.com" <xfs@oss.sgi.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"jack@suse.cz" <jack@suse.cz>, "matthew@wil.cx" <matthew@wil.cx>
Subject: Re: [PATCH v4 5/7] fs: prioritize and separate direct_io from dax_io
Message-ID: <20160508090148.GF15458@infradead.org>
References: <1461878218-3844-1-git-send-email-vishal.l.verma@intel.com>
 <1461878218-3844-6-git-send-email-vishal.l.verma@intel.com>
 <5727753F.6090104@plexistor.com>
 <20160505142433.GA4557@infradead.org>
 <1462484343.29294.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462484343.29294.1.camel@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 05, 2016 at 09:39:14PM +0000, Verma, Vishal L wrote:
> How is it any 'less direct'? All it does now is follow the blockdev
> O_DIRECT path. There still isn't any page cache involved..

It's still more overhead than the play DAX I/O path.
