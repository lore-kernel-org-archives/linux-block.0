Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Tue, 25 Apr 2017 11:00:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: jsmart2021@gmail.com
Subject: Re: [PATCH] lpfc: Fix memory corruption of the lpfc_ncmd->list
 pointers
Message-ID: <20170425180039.GE3575@infradead.org>
References: <20170422004908.24261-1-jsmart2021@gmail.com>
 <20170425175844.GC3575@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170425175844.GC3575@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>, sagi@grimberg.me,
 martin.petersen@oracle.com, jthumshirn@suse.de,
 James Smart <james.smart@broadcom.com>, emilne@redhat.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 25, 2017 at 10:58:44AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 21, 2017 at 05:49:08PM -0700, jsmart2021@gmail.com wrote:
> > This is a nvme-specific bug. The patch was cut against the
> > linux-block tree, for-4.12/block tree. It should be pulled in through
> > that tree.
> 
> It conflicts with your nvme changes that are in the nvme-4.12.
> Can you respin it?

Sorry for the noise.  It applies fine and I've applied it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
