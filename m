Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540503399.66186.60.camel@acm.org>
Subject: Re: [PATCH 08/28] scsi: kill off the legacy IO path
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Himanshu Madhani
	 <himanshu.madhani@cavium.com>
Date: Thu, 25 Oct 2018 14:36:39 -0700
In-Reply-To: <20181025211039.11559-9-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
	 <20181025211039.11559-9-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
+AD4 +AEAAQA -3265,25 +-3261,17 +AEAAQA qla2x00+AF8-probe+AF8-one(struct pci+AF8-dev +ACo-pdev, const struct pci+AF8-device+AF8-id +ACo-id)
+AD4  	    base+AF8-vha-+AD4-mgmt+AF8-svr+AF8-loop+AF8-id, host-+AD4-sg+AF8-tablesize)+ADs
+AD4  
+AD4  	if (ha-+AD4-mqenable) +AHs
+AD4 -		bool mq +AD0 false+ADs
+AD4  		bool startit +AD0 false+ADs
+AD4  
+AD4 -		if (QLA+AF8-TGT+AF8-MODE+AF8-ENABLED()) +AHs
+AD4 -			mq +AD0 true+ADs
+AD4 +-		if (QLA+AF8-TGT+AF8-MODE+AF8-ENABLED())
+AD4  			startit +AD0 false+ADs
+AD4 -		+AH0
+AD4  
+AD4 -		if ((ql2x+AF8-ini+AF8-mode +AD0APQ QLA2XXX+AF8-INI+AF8-MODE+AF8-ENABLED) +ACYAJg
+AD4 -		    shost+AF8-use+AF8-blk+AF8-mq(host)) +AHs
+AD4 -			mq +AD0 true+ADs
+AD4 +-		if (ql2x+AF8-ini+AF8-mode +AD0APQ QLA2XXX+AF8-INI+AF8-MODE+AF8-ENABLED)
+AD4  			startit +AD0 true+ADs
+AD4 -		+AH0
+AD4  
+AD4 -		if (mq) +AHs
+AD4 -			/+ACo Create start of day qpairs for Block MQ +ACo-/
+AD4 -			for (i +AD0 0+ADs i +ADw ha-+AD4-max+AF8-qpairs+ADs i+-+-)
+AD4 -				qla2xxx+AF8-create+AF8-qpair(base+AF8-vha, 5, 0, startit)+ADs
+AD4 -		+AH0
+AD4 +-		/+ACo Create start of day qpairs for Block MQ +ACo-/
+AD4 +-		for (i +AD0 0+ADs i +ADw ha-+AD4-max+AF8-qpairs+ADs i+-+-)
+AD4 +-			qla2xxx+AF8-create+AF8-qpair(base+AF8-vha, 5, 0, startit)+ADs
+AD4  	+AH0
+AD4  
+AD4  	if (ha-+AD4-flags.running+AF8-gold+AF8-fw)

(+-Himanshu)

Since I'm not sure that +ACI-mq+ACI in the above code refers to +ACI-scsi-mq+ACI nor that it
refers to +ACI-blk-mq+ACI, I'm not sure the above changes should be included in this
patch. Himanshu, can you have a look?

+AD4 +-static ssize+AF8-t
+AD4 +-show+AF8-use+AF8-blk+AF8-mq(struct device +ACo-dev, struct device+AF8-attribute +ACo-attr, char +ACo-buf)
+AD4 +-+AHs
+AD4 +-	return snprintf(buf, 20, +ACI-1+AFw-n+ACI)+ADs
+AD4 +-+AH0
+AD4 +-static DEVICE+AF8-ATTR(use+AF8-blk+AF8-mq, S+AF8-IRUGO, show+AF8-use+AF8-blk+AF8-mq, NULL)+ADs

The pattern +ACI-snprintf(buf, 20, ...)+ACI looks like cargo-cult programming to me.
Please consider changing +ACI-snprintf(buf, 20, +ACI into +ACI-sprintf(buf, +ACI.

Thanks,

Bart.
