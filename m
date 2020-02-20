Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52CC11D05
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEB20659
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTQOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:14:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40070 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 11:14:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so1729228plp.7
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 08:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKPHMJwF4MyHd+DQd6050bs+/wHALXSf8Ij2hF72YKM=;
        b=CBqLi3NhD9YhAI/EAMaHyBtqupxfMDBki5kbuGH1MRfTbVHI8rt6uwfDrg8LhU2twG
         AmpkmQiQq9uouudLnjfg8g3xUQIRorrq0Ts2PgBZvr4Hy6szpuN/i9dBuBTUti+b2SLg
         GKcbQkmUWoAejRbQMGBvBnBARcXJb0iA4+cxbrE6lkE2jXLwAlsNHmbwv4WNnewRuY4y
         ZqPT5TBKXYx3VFDq5QZVp16OJ3XYi2Xrzlc8S6zAioOblk1dHo3uLVULk9frHYtZ+QBz
         OfA2l969D0rYu8SWkh4sYgG7e3fHF3/5KzEtgyv8VlBsqxed13u/rtsqov6A50f9v5Mt
         4SJw==
X-Gm-Message-State: APjAAAV7PdoS84eAvWIIuw+Z04lm5W6N1dBydR0hACQb6y6wIJPO1iGT
        pByARfbXrHwFXYWxl95dzgk=
X-Google-Smtp-Source: APXvYqxMXgAQqSseAqA6m4vtFBXKbns0NnoTe6M8jpIMQ2lsYhHJVW9+KbcspyztYNxYvde76GW/Uw==
X-Received: by 2002:a17:902:b70e:: with SMTP id d14mr31906389pls.295.1582215253390;
        Thu, 20 Feb 2020 08:14:13 -0800 (PST)
Received: from ?IPv6:2620:15c:2d1:206:bfe1:be9c:5072:1789? ([2620:15c:2d1:206:bfe1:be9c:5072:1789])
        by smtp.gmail.com with ESMTPSA id h3sm4108432pjs.0.2020.02.20.08.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 08:14:12 -0800 (PST)
Subject: Re: [PATCH v2 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
References: <20200220024441.11558-1-bvanassche@acm.org>
 <20200220024441.11558-3-bvanassche@acm.org>
 <20200220100524.GA31206@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <37505ee7-fba6-1b25-64c4-f632280e8b70@acm.org>
Date:   Thu, 20 Feb 2020 08:14:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220100524.GA31206@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/20 2:05 AM, Ming Lei wrote:
> On Wed, Feb 19, 2020 at 06:44:35PM -0800, Bart Van Assche wrote:
>> blk_mq_map_queues() and multiple .map_queues() implementations expect that
>> set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
> 
> Only single queue mapping expects set->map[HCTX_TYPE_DEFAULT].nr_queues
> to be set->nr_hw_queues. For multiple mapping, set->nr_hw_queues should
> be sum of each mapping's nr_queue.

That's how it should work but that doesn't match what I found in the 
kernel tree. Here is an example of a .map_queues() implementation that 
depends on .nr_queues being set before it is called:

static int scsi_map_queues(struct blk_mq_tag_set *set)
{
	struct Scsi_Host *shost = container_of(set, struct Scsi_Host,
					       tag_set);

	if (shost->hostt->map_queues)
		return shost->hostt->map_queues(shost);
	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
}

If shost->hostt->map_queues == NULL, the above function only works 
correctly if .nr_queues is set before this function is called. 
Additionally, scsi_map_queues() may call e.g. the following function:

static int qla2xxx_map_queues(struct Scsi_Host *shost)
{
	int rc;
	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
	struct blk_mq_queue_map *qmap =
		&shost->tag_set.map[HCTX_TYPE_DEFAULT];

	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
		rc = blk_mq_map_queues(qmap);
	else
		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev,
			vha->irq_offset);
	return rc;
}

Both blk_mq_map_queues() and blk_mq_pci_map_queues() assume that 
blk_mq_queue_map.nr_queues is set before these functions are called.

Bart.
