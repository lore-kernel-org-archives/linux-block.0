Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794AC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15F206A5
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 12:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfLLMEI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:04:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:36612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfLLMEI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 07:04:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B36E2AFAA;
        Thu, 12 Dec 2019 12:04:06 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] xen-blkback: support dynamic unbind/bind
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-5-pdurrant@amazon.com>
 <20191212114616.GC11756@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <48e2da7d-2bf5-9f2a-0675-366ae8d3ce77@suse.com>
Date:   Thu, 12 Dec 2019 13:04:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212114616.GC11756@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.12.19 12:46, Roger Pau Monné wrote:
> On Wed, Dec 11, 2019 at 03:29:56PM +0000, Paul Durrant wrote:
>> By simply re-attaching to shared rings during connect_ring() rather than
>> assuming they are freshly allocated (i.e assuming the counters are zero)
>> it is possible for vbd instances to be unbound and re-bound from and to
>> (respectively) a running guest.
>>
>> This has been tested by running:
>>
>> while true;
>>    do fio --name=randwrite --ioengine=libaio --iodepth=16 \
>>    --rw=randwrite --bs=4k --direct=1 --size=1G --verify=crc32;
>>    done
>>
>> in a PV guest whilst running:
>>
>> while true;
>>    do echo vbd-$DOMID-$VBD >unbind;
>>    echo unbound;
>>    sleep 5;
>>    echo vbd-$DOMID-$VBD >bind;
>>    echo bound;
>>    sleep 3;
>>    done
>>
>> in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind and
>> re-bind its system disk image.
>>
>> This is a highly useful feature for a backend module as it allows it to be
>> unloaded and re-loaded (i.e. updated) without requiring domUs to be halted.
>> This was also tested by running:
>>
>> while true;
>>    do echo vbd-$DOMID-$VBD >unbind;
>>    echo unbound;
>>    sleep 5;
>>    rmmod xen-blkback;
>>    echo unloaded;
>>    sleep 1;
>>    modprobe xen-blkback;
>>    echo bound;
>>    cd $(pwd);
>>    sleep 3;
>>    done
>>
>> in dom0 whilst running the same loop as above in the (single) PV guest.
>>
>> Some (less stressful) testing has also been done using a Windows HVM guest
>> with the latest 9.0 PV drivers installed.
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Thanks!
> 
> Juergen: I guess you will also pick this series and merge it from the
> Xen tree instead of the block one?

Yes.


Juergen
