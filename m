Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDD18DF97;
	Tue, 10 Sep 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967665; cv=none; b=Ps6jqvBSmWmVlXCtlFf93WRTw26vCC2v6oUy88pUycK/UO5pBwDnMeRjz8YLgRZF/x/oBhpTVuMUCKciqYU/+UsJYjMPleJ3WES+BMQDsFK5US8F1ZxW2eWt9wCpkd05OLBl52qod+TBuGxpUpm8duYBdGb0FFrm8xl3Kk+oEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967665; c=relaxed/simple;
	bh=zoWAYfYuiHpToo3ye253Nx+yprXvfGi+CtDBNL0ZanI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwRPkf+G6/PaOqb3R55Khg+HRwisTApfWFk05HtnaUDsQTNr89zLfrXeddb7PblV9DJW5E1f1jtzVl5I3z03Z4qHeRuByBdMpv9l4WUlQ9Ty92QnomuxixmnXMDkcpJvwmj0uhLC1Jrk3N6NnATyMlnBBR1KHlaA16ROXS9CaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF7QdL9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF7QdL9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FB9C4CEC3;
	Tue, 10 Sep 2024 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725967665;
	bh=zoWAYfYuiHpToo3ye253Nx+yprXvfGi+CtDBNL0ZanI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NF7QdL9Nh2QrbblMq0kLrWF2KyVEwpjUebRzu/qJUZARPuPRdj6VqZXE60AqqIbBO
	 +5IX7FqhgBULER+B0STSWkFC5qU4RvzxI3vW9OSwXKkbVpdik235eskgVWXNu7rTHZ
	 oQNqD6mcqMLVMbZx1WRKM+isdBAgf7+pPUTxyhBfz2KUDTb9ij50NVXfEetVmeMSjE
	 SEnhrG3uztDxa/PLQ1chwnrRu0zcpouxbLyhrw1PAPH2b2qnZYv3CVDLuIVrufh24E
	 LIfD/xBWAXAGqmYcDgOzvHMew81NXbqDNEtotiK5srd8nGOrDBQNB7WV3ebz8Y4o6N
	 8txRk+n0RUZzQ==
Date: Tue, 10 Sep 2024 13:27:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: yangxingui <yangxingui@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, axboe@kernel.dk,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	damien.lemoal@opensource.wdc.com
Subject: Re: [bug report] block: Non-NCQ commands will never be executed
 while fio is continuously running
Message-ID: <ZuAtLK5jIPEjhXmU@ryzen.lan>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>

On Tue, Sep 10, 2024 at 02:34:06PM +0800, yangxingui wrote:
> 
> 
> On 2024/9/10 12:45, Damien Le Moal wrote:
> > On 9/10/24 10:09 AM, yangxingui wrote:
> > > 
> > > 
> > > On 2024/9/9 21:21, Damien Le Moal wrote:
> > > > On 9/9/24 22:10, yangxingui wrote:
> > > > > Hello axboe & John,
> > > > > 
> > > > > After the driver exposes all HW queues to the block layer, non-NCQ
> > > > > commands will never be executed while fio is continuously running, such
> > > > > as a smartctl command.
> > > > > 
> > > > > The cause of the problem is that other hctx used by the NCQ command is
> > > > > still active and can continue to issue NCQ commands to the sata disk.
> > > > > And the pio command keeps retrying in its corresponding hctx because
> > > > > qc_defer() always returns true.
> > > > > 
> > > > > hctx0: ncq, pio, ncq
> > > > > hctx1：ncq, ncq, ...
> > > > > ...
> > > > > hctxn: ncq, ncq, ...
> > > > > 
> > > > > Is there any good solution for this?
> > > > 
> > > > SATA devices are single queue so how can you have multiple queues ?
> > > > What adapter are you using ?
> > > 
> > > In the following patch, we expose the host's 16 hardware queues to the block
> > > layer. And when connecting to a sata disk, 16 hctx are used.
> > > 
> > > 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")
> > 
> > OK, so the HBA is a hisi one, using libsas...
> > What is the device ? An SSD ? and HDD ?
> Both SATA SSD and SATA HDD have this problem.
> 
> > 
> > Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
> > setting a scheduler resolve the issue ?
> Currently, the default configuration mq-deadline is used, and the same
> phenomenon occurs when I try setting it to none. It seems to have nothing to
> do with the scheduling strategy.
> 
> > 
> > I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
> > have multiple queues with a shared tagset. Never seen the issue you are
> > reporting though using HDDs with mq-deadline or bfq as the scheduler.
> Unlike libsas, as these hosts don't use qc_defer()?

mpt3sas and mpi3mr do not use any libata code at all, the SCSI to ATA
Translation (SAT) is done completely by the HBA, so from a Linux
perspective, we are issuing SCSI commands to the HBA.

We can see that libsas uses ata_std_qc_defer() as its .qc_defer callback:
https://github.com/torvalds/linux/blob/v6.11-rc7/drivers/scsi/libsas/sas_ata.c#L566


If you look at SATA 3.a Gold specification,
"13.6.3 Intermixing Non-NCQ commands and NCQ commands"

"The host shall not issue a non-NCQ command while an NCQ command is outstanding."


In AHCI 1.3.1 specification,
"1.7 Theory of Operation"

"System software is responsible to ensure that queued and non-queued commands
are not mixed in the command list for the same device with the exception of
the NCQ Unload command."


Usually, tools like smartctl submit SCSI commands of type "ATA-16 passthrough",
which is a specific SCSI command that just contains a regular ATA command as
payload:
https://www.smartmontools.org/browser/trunk/smartmontools/scsiata.cpp?desc=1&order=date#L346

For a "ATA-16 passthrough" SCSI command, libata will simply copy the fields
from the "ATA-16 passthrough" SCSI command to the appropriate field in a newly
created ATA command, see the SAT specification and:
https://github.com/torvalds/linux/blob/v6.11-rc7/drivers/ata/libata-scsi.c#L2878-L2887


See also the SAT-6 specification,
"6.2.4 Mechanism for processing some commands as NCQ commands"

"The ACS-5 standard defines a mechanism for NCQ encapsulation of some commands.
Use of this mechanism allows these commands to be processed without quiescing
the ATA device."

Without considering if it is a good idea or not, it should be possible to
translate some commands to instead use the "NCQ encapsulated" variant of
the ATA command that was used in the "ATA-16 passthrough" SCSI command.

However looking at e.g.:
https://www.smartmontools.org/browser/trunk/smartmontools/scsiata.cpp?desc=1&order=date#L566
smartctl is sending a IDENTIFY DEVICE (ECh) ATA command,
and this command has no NCQ encapsulated variant.

(Had the application instead used a READ LOG DMA EXT command to read the
IDENTIFY DEVICE data log, where log page 01h is a copy of IDENTIFY DEVICE data,
we would have been able to convert the command to an NCQ encapsulated variant.)



TL;DR: I do not see easy generic solution to this problem.

To be able to send a non-queued command, there has to be no NCQ commands queued
on the device. I guess you could implement a scheduler that would be quiescing
the queue, processes the non-queued command, and then thaw the queue, but that
would essentially make non-queued commands high priority commands, and could
thus be used to seriously limit throughput by just sending some non-queued
commands every now and then :)


Kind regards,
Niklas
