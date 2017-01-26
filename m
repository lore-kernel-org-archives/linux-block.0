Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Thu, 26 Jan 2017 18:52:47 +0000
Message-ID: <1485456745.2540.9.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485455329.2540.7.camel@sandisk.com>
         <e8f4b084-be66-d5b3-5785-13b80642040f@fb.com>
In-Reply-To: <e8f4b084-be66-d5b3-5785-13b80642040f@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-01-26 at 11:44 -0700, Jens Axboe wrote:
> I think this may be my bug - does the below help?

Hello Jens,

What tree has that patch been generated against? It does not apply
cleanly on top of Christoph's tree:

$ git checkout hch-block-pc-refactor
$ patch -p1 --dry-run -f -s < ~/Re\:_split_scsi_passthrough_fields_out_of_s=
truct_request_V2.mbox
1 out of 3 hunks FAILED

Thanks,

Bart.=
