Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1on0073.outbound.protection.outlook.com ([157.56.110.73]:42592
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750753AbcF1H1M (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 03:27:12 -0400
Subject: Re: [PATCH v5 2/5] mmc: move 'parent' tracking to mmc_blk_data
To: Dan Williams <dan.j.williams@intel.com>, <axboe@fb.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146705580308.39775.10937037092465199137.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-nvdimm@lists.01.org>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	"Bart Van Assche" <bart.vanassche@sandisk.com>, <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <43a3a08c-d1f5-5dd8-dfee-8cfba7530084@sandisk.com>
Date: Tue, 28 Jun 2016 09:26:59 +0200
MIME-Version: 1.0
In-Reply-To: <146705580308.39775.10937037092465199137.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/27/2016 09:30 PM, Dan Williams wrote:
> In preparation for the removal of 'driverfs_dev' from 'struct gendisk',
> carry this data in mmc_blk_data. It is used for registration of parent
> disks and partitions.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
