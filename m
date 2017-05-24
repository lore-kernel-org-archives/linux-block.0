Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 31/31] xen/scsifront: Remove code that zeroes
 driver-private command data
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-32-bart.vanassche@sandisk.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <10eedc1d-a5cf-d4fd-e470-172631f07645@suse.com>
Date: Wed, 24 May 2017 09:02:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-32-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 24/05/17 02:34, Bart Van Assche wrote:
> Since the SCSI core zeroes driver-private command data, remove
> that code from the xen-scsifront driver.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org

Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks,

Juergen
