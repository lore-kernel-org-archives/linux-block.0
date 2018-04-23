Return-Path: <maier@linux.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <89ca9f7d20c24a3d9c743c7f5ca2d108@SIWEX5A.sing.micron.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:58:24 +0200
MIME-Version: 1.0
In-Reply-To: <89ca9f7d20c24a3d9c743c7f5ca2d108@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3298b85a-6a64-3b12-93c6-989c166bfb53@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>


On 04/17/2018 12:00 PM, Bean Huo (beanhuo) wrote:

> #Cat trace
> iozone-4055  [000] ....   665.039276: block_unplug: [iozone] 1 Sync
> iozone-4055  [000] ...1   665.039278: block_rq_insert: 8,48 WS 0 () 396=
04352 + 128 tag=3D18 [iozone]
> iozone-4055  [000] ...1   665.039280: block_rq_issue: 8,48 WS 0 () 3960=
4352 + 128 tag=3D18 [iozone]
> iozone-4055  [000] ...1   665.039284: scsi_dispatch_cmd_start: host_no=3D=
0 channel=3D0 id=3D0 lun=3D3 data_sgl=3D16 prot_sgl=3D0 prot_op=3DSCSI_PR=
OT_NORMAL tag=3D18 cmnd=3D(WRITE_10 lba=3D4950544 txlen=3D16 protect=3D0 =
raw=3D2a 00 00 4b 8a 10 00 00 10 00)
> iozone-4056  [002] ....   665.039284: block_dirty_buffer: 8,62 sector=3D=
44375 size=3D4096
> <idle>-0     [000] d.h2   665.039319: scsi_dispatch_cmd_done: host_no=3D=
0 channel=3D0 id=3D0 lun=3D3 data_sgl=3D16 prot_sgl=3D0 prot_op=3DSCSI_PR=
OT_NORMAL tag=3D24 cmnd=3D(WRITE_10 lba=3D4944016 txlen=3D16 protect=3D0 =
raw=3D2a 00 00 4b 70 90 00 00 10 00) result=3D(driver=3DDRIVER_OK host=3D=
DID_OK message=3DCOMMAND_COMPLETE status=3DSAM_STAT_GOOD)
> <idle>-0     [000] d.h3   665.039321: block_rq_complete: 8,48 WS () 395=
52128 + 128 tag=3D24 [0]

> iozone-4058  [003] ....   665.039362: block_bio_remap: 8,48 WS 39568768=
 + 128 <- (8,62) 337280
> iozone-4058  [003] ....   665.039364: block_bio_queue: 8,48 WS 39568768=
 + 128 [iozone]
> iozone-4058  [003] ...1   665.039366: block_getrq: 8,48 WS 39568768 + 1=
28 [iozone]

I'm not familiar with block/scsi command tagging.

Some block events now would get a tag field.
Some block events would not get a tag field (maybe because for some the=20
tag is not (yet) known).

So all block events that belong to the same request would still need to=20
be correlated by something like (devt, RWBS, LBA, length) because not=20
all have a tag field.

> Especially, the ftrace log with tag information, I can easily figure ou=
t one I/O request between block layer and SCSI.

Provided this is done correctly, I would be in favor of a solution.
Since
v4.11 commit 48b77ad60844 (``block: cleanup tracing'')\newline
v4.11 commit 82ed4db499b8 (``block: split scsi\_request out of struct=20
request'')
we don't have the SCSI CDB in block traces (nor in blktrace traditional=20
relayfs trace format, nor in ftrace 'blk' tracer binary synthesized=20
output [1]) any more (empty Packet Command payload).
Being able to correlate block events with scsi events would indeed be=20
very helpful for some cases.

Is a correlation between block and scsi only necessary for these pairs?:

block_rq_issue causes scsi_dispatch_cmd_start, and
scsi_dispatch_cmd_done causes block_rq_complete.

If so, only those two block trace events would need to get a new field?


[1] v2.6.30 commit 08a06b83ff8b (``blkftrace: binary tracing,=20
synthesizing old format'')
     v2.6.31 commit f3948f8857ef (``blktrace: fix context-info when=20
mixed-using blk tracer and trace events'')

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
