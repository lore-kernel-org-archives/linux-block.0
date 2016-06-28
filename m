Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0094.outbound.protection.outlook.com ([65.55.169.94]:22816
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751605AbcF1HhO (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 03:37:14 -0400
Subject: Re: [PATCH v5 4/5] block: convert to device_add_disk()
To: Dan Williams <dan.j.williams@intel.com>, <axboe@fb.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146705581355.39775.16995803612126463831.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	<linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <keith.busch@intel.com>,
	<linux-nvdimm@lists.01.org>, <linux-block@vger.kernel.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Ross Zwisler" <ross.zwisler@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>, <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <b4798a72-54f2-9b07-d13a-6eaf90cedb1a@sandisk.com>
Date: Tue, 28 Jun 2016 09:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <146705581355.39775.16995803612126463831.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/27/2016 09:30 PM, Dan Williams wrote:
> For block drivers that specify a parent device, convert them to use
> device_add_disk().

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
