Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH rfc 01/10] nvme-pci: Split __nvme_process_cq to poll and
 handle
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-2-git-send-email-sagi@grimberg.me>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <872aed98-0974-820d-c8fc-0300e40c8fcb@suse.de>
Date: Thu, 9 Mar 2017 14:57:44 +0100
MIME-Version: 1.0
In-Reply-To: <1489065402-14757-2-git-send-email-sagi@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> Just some rework to split the logic and make it slightly
> more readable. This will help us to easily add the irq-poll
> logic.
> =

> Also, introduce nvme_ring_cq_doorbell helper to mask out the
> cq_vector validity check.
> =

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- =

Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
