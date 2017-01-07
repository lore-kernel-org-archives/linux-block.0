Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Changho Choi <changho.c@samsung.com>
To: Andreas Dilger <adilger@dilger.ca>
Subject: RE: [LSF/MM TOPIC] status update on stream IDs
Date: Sat, 07 Jan 2017 02:06:27 +0000
Message-id: <8F1CD504A027484E89249BCD2A7248DD5867B290@SSIEXCH-MB3.ssi.samsung.com>
In-reply-to: <87B8B7C67ECB1048AE5FA3C64D62B73E1CA9473A@SSIEXCH-MB3.ssi.samsung.com>
MIME-version: 1.0
References: <E86FC13D-0058-473C-B9D6-36B988ABEFFE@dilger.ca>
 <CGME20170106235940epcas4p1b4e8c499548496e1bfabb83e818d5b71@epcas4p1.samsung.com>
 <7B0B6B53-D692-4084-AC63-55138132F509@dilger.ca>
 <87B8B7C67ECB1048AE5FA3C64D62B73E1CA9473A@SSIEXCH-MB3.ssi.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Kwan \(Hingkwan\) Huen" <kwan.huen@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Andreas,

Thanks for the heads up!

There has been big progress on it. It was ratified as a NVMe 1.3 standard in Oct 31st, 2016 in NVMe org(As you may already understand it was ratified as SCSI standard in T10 in May, 2015).
The standard compliant product is available for NVMe and SAS in the market.
Also Jens Axboe implemented the features in Kernel, etc. 

We are more than happy to update the status in the meeting. 
Also it would be a great time to revive the Linux Kernel implementation discussion to support both application-assigned stream ID and kernel-assigned stream ID at the same time. 
I think people will start circulating the possible approaches sooner or later unless it is already started.

Thanks,
Changho


[resend to include other relevant lists]

On Jan 6, 2017, at 4:54 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>
> At LSF/MM'16 and Linux FAST (https://lwn.net/Articles/685499/) there 
> were discussions about adding stream IDs to the block/device layer to 
> allow higher layers (filesystems, applications) to identify IO streams 
> so lower layers (SSDs, hybrid storage, etc.) can make better allocation/placement decisions.
>
> It would be useful to get an update on the state of this work, and 
> discuss any obstacles that need to be resolved for getting this code landed.


Cheers, Andreas






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
