Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbdLEQn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Dec 2017 11:43:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB5GhjRv080548
        for <linux-block@vger.kernel.org>; Tue, 5 Dec 2017 11:43:59 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eny1qgreb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 05 Dec 2017 11:43:59 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 5 Dec 2017 09:43:58 -0700
Subject: Re: [PATCH 1/2] scsi-mq: Only show the CDB if available
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>
Date: Tue, 05 Dec 2017 08:43:49 -0800
In-Reply-To: <20171205163824.GB23788@ming.t460p>
References: <20171205003809.1705-1-bart.vanassche@wdc.com>
         <20171205003809.1705-2-bart.vanassche@wdc.com>
         <20171205011536.GC8365@ming.t460p> <1512439190.2739.0.camel@wdc.com>
         <20171205050008.GA9989@ming.t460p> <1512490952.2660.18.camel@wdc.com>
         <20171205163824.GB23788@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512492229.3019.25.camel@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-12-06 at 00:38 +0800, Ming Lei wrote:
> On Tue, Dec 05, 2017 at 04:22:33PM +0000, Bart Van Assche wrote:
> > 
> > On Tue, 2017-12-05 at 13:00 +0800, Ming Lei wrote:
> > > 
> > > No, do not mix two different things in one patch, especially the
> > > fix part need to be backported to stable.
> > > 
> > > The fix part should aim at V4.15, and the other part can be a
> > > V4.16 stuff.
> > 
> > Does this mean that you do not plan to post a v5 of your patch and
> > that you want me to rework this patch series? I can do that.
> 
> I believe V4 has been OK for merge, actually the only concern from
> James is that 'set the cmnd to NULL *before* calling free so we
> narrow the race window.', but that isn't required as I explained,
> even though you don't do that in this patch too.
> 
> 	https://marc.info/?t=151030464300003&r=1&w=2
> 
> I will work on V5 if Martin/James thinks it is needed.

I don't buy that it isn't needed.  The point (and the pattern) is for a
destructive action set the signal *before* you execute the action not
after.  The reason should be obvious: if you set it after you invite a
race where the check says OK but the object has gone.  Even if the race
is highly unlikely, the pattern point still holds.

James
