Return-Path: <SRS0=bVZU=HF=goodmis.org=rostedt@kernel.org>
Date: Mon, 16 Apr 2018 11:28:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "jejb@linux.vnet.ibm.com"
 <jejb@linux.vnet.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mingo@redhad.com" <mingo@redhad.com>,
 "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>,
 "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI
 trace events
Message-ID: <20180416112810.57a3f74b@gandalf.local.home>
In-Reply-To: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon, 16 Apr 2018 14:31:49 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:

> Print the request tag along with other information
> while tracing a command.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---

I don't see any issue with the tracing part.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Others need to check the content.

-- Steve
