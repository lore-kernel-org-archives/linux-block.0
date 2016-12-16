Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752203AbcLPTZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2016 14:25:17 -0500
Subject: Re: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
To: Stephen Bates <sbates@raithlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
CC: <sagi@grimberg.me>, <james_p_freyensee@linux.intel.com>,
        <jonathan.derrick@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <365e0b2b-06b1-dc0b-a9ae-dc901ca98d6a@fb.com>
Date: Fri, 16 Dec 2016 12:23:28 -0700
MIME-Version: 1.0
In-Reply-To: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/16/2016 11:54 AM, Stephen Bates wrote:
> Hi
> 
> This series adds some more verbosity to the NVMe CMB sysfs entry.
> 
> Jens I based this off v4.9 because for some reason your for-4.10/block
> is missing my original CMB commit (202021c1a63c6)?

for-4.10/block was forked off v4.9-rc1, and that patch didn't make it
in until v4.9-rc2. Since for-4.10/block has been merged, any patches
for this series or next should be based on my for-linus, or just master.

Assuming these two apply directly to master as well?

-- 
Jens Axboe

