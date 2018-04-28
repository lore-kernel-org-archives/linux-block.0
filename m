Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753203AbeD1IRv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Apr 2018 04:17:51 -0400
Date: Sat, 28 Apr 2018 16:17:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@fb.com" <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "james.bottomley@hansenpartnership.com"
        <james.bottomley@hansenpartnership.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 2/3] scsi: read host_busy via scsi_host_busy()
Message-ID: <20180428081726.GA7325@ming.t460p>
References: <20180420065742.8043-1-ming.lei@redhat.com>
 <20180420065742.8043-3-ming.lei@redhat.com>
 <6112db0045837d0583d4b30aa4a1fd2bc4bdc239.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6112db0045837d0583d4b30aa4a1fd2bc4bdc239.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 27, 2018 at 03:51:46PM +0000, Bart Van Assche wrote:
> On Fri, 2018-04-20 at 14:57 +0800, Ming Lei wrote:
> >  show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
> >  {
> >  	struct Scsi_Host *shost = class_to_shost(dev);
> > -	return snprintf(buf, 20, "%d\n", atomic_read(&shost->host_busy));
> > +	return snprintf(buf, 20, "%d\n", scsi_host_busy(shost));
> >  }
> >  static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
> 
> The ", 20" part is cargo-cult programming. Since you have to touch this code,
> please either use "sprintf(buf, ...)" or use "scnprintf(buf, PAGE_SIZE, ...)".

This patch is only to replace atomic_read(&shost->host_busy) with
scsi_host_busy(shost) which returns 'int' too, so nothing related
with snprintf(buf, 20,..).

No mention the string with 20 length is enough to hold integer, so it
isn't needed too. 

So I don't see any reason to do that in this patch.

Thanks, 
Ming
