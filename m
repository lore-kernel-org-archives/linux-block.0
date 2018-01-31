Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
MIME-Version: 1.0
Date: Wed, 31 Jan 2018 11:43:33 -0700
From: Scotty Bauer <sbauer@eng.utah.edu>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM TOPIC] KPTI effect on IO performance
In-Reply-To: <20180131082331.GA25888@ming.t460p>
References: <20180131082331.GA25888@ming.t460p>
Message-ID: <d6729ac299e153de259cb8f8af0c888b@eng.utah.edu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, Linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 2018-01-31 01:23, Ming Lei wrote:
> Hi All,
> 
> After KPTI is merged, there is extra load introduced to context switch
> between user space and kernel space. It is observed on my laptop that 
> one
> syscall takes extra ~0.15us[1] compared with 'nopti'.
> 
> IO performance is affected too, it is observed that IOPS drops by 32% 
> in
> my test[2] on null_blk compared with 'nopti':
> 
> randread IOPS on latest linus tree:
> -------------------------------------------------
> | randread IOPS     | randread IOPS with 'nopti'|
> ------------------------------------------------
> | 928K              | 1372K                     |
> ------------------------------------------------
> 
> 

Do you know if your CPU has PCID? It would be interesting to see these 
tests on older CPUs or older kernels without PCID support.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
