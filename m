Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bon0067.outbound.protection.outlook.com ([157.56.111.67]:24112
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932438AbcFTNg2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 20 Jun 2016 09:36:28 -0400
Subject: Re: [PATCH v3 1/3] block: introduce device_add_disk()
To: Dan Williams <dan.j.williams@intel.com>,
	<linux-block@vger.kernel.org>
References: <146618127395.31030.11800447312061202344.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146618127928.31030.14749842741360356417.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: <axboe@fb.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>,
	"Johannes Thumshirn" <jthumshirn@suse.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <dc24a951-eb95-c5bd-68e0-b553a1436ea0@sandisk.com>
Date: Mon, 20 Jun 2016 15:36:18 +0200
MIME-Version: 1.0
In-Reply-To: <146618127928.31030.14749842741360356417.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/17/2016 06:34 PM, Dan Williams wrote:
> In preparation for removing the ->driverfs_dev member of a gendisk, add
> an api that takes the parent device as a parameter to add_disk().  For
> now this maintains the status quo of WARN()ing on failure, but not
> return a error code.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
