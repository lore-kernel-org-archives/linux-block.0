Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:60556
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932385AbcIZW0p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 18:26:45 -0400
Subject: Re: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
To: Mike Snitzer <snitzer@redhat.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <20160926183308.GA13309@redhat.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <8c5fb60c-0bb5-e405-eaba-576b5f8bd244@sandisk.com>
Date: Mon, 26 Sep 2016 15:26:37 -0700
MIME-Version: 1.0
In-Reply-To: <20160926183308.GA13309@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/26/2016 11:33 AM, Mike Snitzer wrote:
> How much testing has this series seen?  Did you run it against the
> mptest testsuite? https://github.com/snitm/mptest

Hello Mike,

The output of mptest with MULTIPATH_BACKEND_MODULE="scsidebug":
# ./runtest
[ ... ]
SUCCESS
** summary **
PASSED:  test_00_no_failure test_01_sdev_offline test_02_sdev_delete 
test_03_dm_failpath test_04_dm_switchpg
FAILED:

I think this is the output we were hoping to see :-)

Bart.
