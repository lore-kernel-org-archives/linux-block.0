Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753335AbdBQTmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 14:42:45 -0500
Subject: Re: OPAL fixups
To: Christoph Hellwig <hch@lst.de>, <scott.bauer@intel.com>,
        <keith.busch@intel.com>, <jonathan.derrick@intel.com>
References: <20170217125941.14319-1-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b8891d4f-4ecf-4646-1e9b-e82009a17dc5@fb.com>
Date: Fri, 17 Feb 2017 12:42:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/17/2017 05:59 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this contains a few more OPAL-related fixups.  It tones down warnings a bit,
> allocates the OPAL-ѕpecific data structure in a separate dynamic allocation,
> checks for support of Security Send/Receive in NVMe before using them,
> and makes sure we re-discovery the security capabilities after each reset.

Applied 1-3, thanks.

-- 
Jens Axboe
