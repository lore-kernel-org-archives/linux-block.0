Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 1 Feb 2018 10:35:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Scotty Bauer <sbauer@eng.utah.edu>
Message-ID: <20180201023520.GA23923@ming.t460p>
References: <20180131082331.GA25888@ming.t460p>
	<d6729ac299e153de259cb8f8af0c888b@eng.utah.edu>
MIME-Version: 1.0
In-Reply-To: <d6729ac299e153de259cb8f8af0c888b@eng.utah.edu>
Cc: linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, Linux-scsi@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] KPTI effect on IO performance
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

Hi Scotty,

On Wed, Jan 31, 2018 at 11:43:33AM -0700, Scotty Bauer wrote:
> On 2018-01-31 01:23, Ming Lei wrote:
> > Hi All,
> > 
> > After KPTI is merged, there is extra load introduced to context switch
> > between user space and kernel space. It is observed on my laptop that
> > one
> > syscall takes extra ~0.15us[1] compared with 'nopti'.
> > 
> > IO performance is affected too, it is observed that IOPS drops by 32% in
> > my test[2] on null_blk compared with 'nopti':
> > 
> > randread IOPS on latest linus tree:
> > -------------------------------------------------
> > | randread IOPS     | randread IOPS with 'nopti'|
> > ------------------------------------------------
> > | 928K              | 1372K                     |
> > ------------------------------------------------
> > 
> > 
> 
> Do you know if your CPU has PCID? It would be interesting to see these tests
> on older CPUs or older kernels without PCID support.

My CPU has PCID, which can be retrieved via /proc/cpuinfo.

And the above test is run on same kernel binary, and the result is just done
between 'nopti' and no 'nopti' in kernel command line.

Thanks,
Ming
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
