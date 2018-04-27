Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1524844550.30534.1.camel@redhat.com>
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "axboe@kernel.dk"
	 <axboe@kernel.dk>, "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de"
 <hare@suse.de>,  "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "don.brace@microsemi.com" <don.brace@microsemi.com>,
 "james.bottomley@hansenpartnership.com"
 <james.bottomley@hansenpartnership.com>, "osandov@fb.com" <osandov@fb.com>,
  "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Date: Fri, 27 Apr 2018 11:55:50 -0400
In-Reply-To: <647b4fe833fdf001f724cfa0803c9e3a79d78b13.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
	 <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
	 <607c4d2f-28e7-4152-dbf5-7fb4387e9413@kernel.dk>
	 <647b4fe833fdf001f724cfa0803c9e3a79d78b13.camel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-04-27 at 15:48 +0000, Bart Van Assche wrote:
> On Fri, 2018-04-27 at 09:39 -0600, Jens Axboe wrote:
> > blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
> > 			&in_flight);
> > return in_flight.cnt + atomic_read(&shost->host_busy);
> > 
> > The atomic read is basically free, once we get rid of the dirty of
> > that
> > variable on each IO.
> 
> Hello Jens,
> 
> What makes you think that " + atomic_read(&shost->host_busy)" is
> necessary?
> I am not aware of any code outside the SCSI core that modifies the
> host_busy
> member.
> 
> Thanks,
> 
> Bart.
> 
> 
> 

As part of testing latest upstream in MQ and non-MQ I intend to test
this patch series fully on actual hardware
F/C 8G to memory backed array LUNS and of course SRP/RDMA
I have started working on this and will report back.
Thanks
Laurence
