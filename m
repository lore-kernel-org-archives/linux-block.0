Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540397093.66186.13.camel@acm.org>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Mike Snitzer
	 <snitzer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com,  Christoph Hellwig <hch@lst.de>, Matias Bjorling
 <matias.bjorling@wdc.com>
Date: Wed, 24 Oct 2018 09:04:53 -0700
In-Reply-To: <yq1zhv3e4oe.fsf@oracle.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
	 <78778e22-9c5e-99d0-ef5c-85e04d03a4b7@kernel.dk>
	 <yq1o9bkf5av.fsf@oracle.com> <20181024150344.GB13487@redhat.com>
	 <yq1zhv3e4oe.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-24 at 11:37 -0400, Martin K. Petersen wrote:
+AD4 Mike,
+AD4 
+AD4 +AD4 +AD4 You keep mentioning this, but I don't recall ever seeing anything to
+AD4 +AD4 +AD4 that effect. The rest of the kernel appears to be either arbitrary
+AD4 +AD4 +AD4 ordering or favoring author SoB as the first tag.
+AD4 +AD4 
+AD4 +AD4 I've always felt the proper order is how Jens likes it too (all dm
+AD4 +AD4 commits from me follow that order).
+AD4 
+AD4 That's fine, I don't have any particular preference. And I don't have
+AD4 any issue with you guys sticking to a certain ordering in your
+AD4 respective subsystems. I occasionally shuffle tags when I commit things
+AD4 in SCSI too.
+AD4 
+AD4 I just think it should be properly documented if there is a preferred
+AD4 way to order things...

When I tried to look up documentation for this I couldn't find anything under
the Documentation directory. Maybe it's there but I didn't look carefully
enough. All I could find on the web is e-mails from Linus in which he explains
that the order of Signed-off-by's should match the chain of authorship.

Bart.
