Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1on0091.outbound.protection.outlook.com ([157.56.110.91]:64004
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751419AbcF1HaV (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 03:30:21 -0400
Subject: Re: [PATCH v5 5/5] block: remove ->driverfs_dev
To: Dan Williams <dan.j.williams@intel.com>, <axboe@fb.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146705581912.39775.9811510607157155243.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Ross Zwisler" <ross.zwisler@linux.intel.com>, <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <138e3e1a-8987-4770-8155-482bfffe5804@sandisk.com>
Date: Tue, 28 Jun 2016 09:30:11 +0200
MIME-Version: 1.0
In-Reply-To: <146705581912.39775.9811510607157155243.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/27/2016 09:30 PM, Dan Williams wrote:
> Now that all drivers that specify a ->driverfs_dev have been converted
> to device_add_disk(), the pointer can be removed from struct gendisk.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
