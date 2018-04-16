Return-Path: <beanhuo@micron.com>
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Steven Rostedt <rostedt@goodmis.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com"
	<Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "rajatja@google.com" <rajatja@google.com>
Subject: [RESEND PATCH v1 0/2] Print the request tag in Block/SCSI trace
 events
Date: Mon, 16 Apr 2018 14:30:03 +0000
Message-ID: <7a9ea1426253406a91253a0501783c90@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

These patches are to add the printout of the request tag in Block/SCSI trac=
e
events when tracing one request or command, this is very useful for tracing
the task running status in the storage device which supports multiple comma=
nd
queue.

As for the first patch " Add tag in SCSI trace events", copied from
Rajat Jain [1]. I am just re-sending here.
=20
[1]https://patchwork.kernel.org/patch/6399661/

-- Resend since patches need to go through the block and SCSI subsystem, an=
d need related
maintainer's confirmation.

Bean Huo (2):
  trace: events: scsi: Add tag in SCSI trace events
  trace: events: block: Add tag in block trace events

 include/trace/events/block.h | 36 +++++++++++++++++++++++++-----------
 include/trace/events/scsi.h  | 20 +++++++++++++-------
 2 files changed, 38 insertions(+), 18 deletions(-)

--=20
2.7.4
