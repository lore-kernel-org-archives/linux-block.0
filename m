Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:17702
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1034709AbdAFXGD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Jan 2017 18:06:03 -0500
Date: Fri, 6 Jan 2017 15:05:54 -0800
From: Adam Manzanares <adam.manzanares@wdc.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: <lsf-pc@lists.linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@linaro.org>, <linux-block@vger.kernel.org>,
        <cyril.guyot@wdc.com>
Subject: Re: [LSF/MM ATTEND AND AGENDA TOPIC] request to attend the summit
Message-ID: <20170106230553.GA23927@hgst.com>
References: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The 01/02/2017 19:14, Paolo Valente wrote:
> Hi,
> this is to retry to request to attend the summit.  This time I'm
> trying to propose and agenda topic too.
> 
> I would like to attend, and propose a topic, because:
> 1) the project for adding (only) the BFQ I/O scheduler to blk-mq has
> entered a quite active phase: the framework prepared by Jens seems
> mostly ready and complete, and I need just a few details to complete
> the port of BFQ.
> 2) the landing of BFQ into blk-mq might have possibly important
> consequences, in a way or the other.
> 
> So, it might be quite useful for me, and possibly for other
> developers/stakeholders interested in these changes and consequences,
> to have the opportunity to talk with each other, exactly when, or
> right after these changes happen.
> 
> In addition, a few months ago Greg KH and James Bottomley even
> suggested to postpone to this summit, or Vault, the KS discussion that
> I proposed on the unsolved latency problems for which BFQ has been
> devised.  So, my topic proposal would be exactly this:
> "Unsolved latency problems, related to I/O, in Linux: consequences on
> lsb-compliant and Android systems, solutions proposed so far, possible
> next solutions".

Hello,

We are also interested in the unsolved latency problems. In 4.10 we got 
some patches merged that deal with iopriority being passed from the 
application to device drivers that send commands to SATA HDDs. This allows an 
application to achieve better tail latencies for prioritized workloads 
when queuing is enabled at the device. 

We would like to discuss the implications of adapting this work to block-mq 
and BFQ. In addition we would like to discuss potential applications and 
devices (including device driver changes) that would benefit from having 
iopriority information.

Thanks,
Adam 

> 
> If needed, I can provide more details on this topic.
> 
> As for the expertise that I may bring, I'm somehow expert in:
> guaranteeing a good system and application responsiveness (a low lag
> in typical Android terminology), providing strong low-latency
> guarantees to video/audio playing/streaming applications, guaranteeing
> a fair share of the bandwidth, and not just the time, of I/O
> resources.
> 
> I would like to submit a talk proposal to Vault too.
> 
> Thanks,
> Paolo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
