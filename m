Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F2DC04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469B2146D
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ8sf+iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1469B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725750AbeLBIGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:06:00 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46899 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBIGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 03:06:00 -0500
Received: by mail-qt1-f170.google.com with SMTP id y20so9766709qtm.13;
        Sat, 01 Dec 2018 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9LwTYa3Xdwx1BUiETExxUbe82rnejmY2L2/SOk3it8k=;
        b=QQ8sf+iHAGCMlM/Arwb342lLtF3XVnM3QgxCACTXNLuSWeSCXWzh60Vz5Jn1yD6ixQ
         JlJsd4FGS/noq2VS8AfbysenfrJLh08qxo+qG2vf4+Zs4jN1c1TzQhsN3Uib4M6lI5ce
         cAFwG0L327HCBopSK23AYg2FXE/BmqVW2RXJ6DUST9iNb5wW8KKo0A4KMjtddnrg+R3I
         X0QqVlImJqsVQOVA1vTy5CveBK5m1Avlw4WHwwDJBmQIEbmLiS5b+sx4fED+AiLeb/DB
         wKUwQEMTXY9ebOIRfa4sWJ1ldPbGFMT+NCbpeC6BacBDGWGw4y569hwLPk9RUDgXPCkB
         sFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9LwTYa3Xdwx1BUiETExxUbe82rnejmY2L2/SOk3it8k=;
        b=f3cBAR5nOc1k7tYGPs4p77VCuZ5oNyH6KfiaQgoBJJ69ZpRSoqjf8fHW4j/cw4uqnJ
         5htm2LQl0Mt+lLgsS4lduTOrB8q61DDMv5jGXA5LPPmWh2BYcxH1jiHp4c2DyZjvHQ7i
         67Xto/tlemE7BpHXoNbqbELcFVWXnxU3vVcf/Aq0ysSjDzkboxezAiEc+6sFYvjudnfN
         sHPL49CIzmlbjeFcCOiTIMbL1Z9otE4mjlxjt3bZEn2JV8Oe8sY8rYv70KzHcwDn/lec
         UqyAN3ho4HYBmCgoxtjDsWra5vj/NOpHZsR5cQciOYqlBYLdo7vuG06FnbmLgA7APXkT
         rpRQ==
X-Gm-Message-State: AA+aEWYgKkmGPocL3YGZDsTvfLlSLTT6nPn5QL4K7y2roJNWqV5EMm6/
        WJ4S69GJYot99N9+9piFxlktxrX2oRA=
X-Google-Smtp-Source: AFSGD/UYBObNscSUahTxl/UwyZ1Y2sK2SjsV8yQmhWd20dCo+mqXJW3bTnFlEat06XzL4yuLAW7QqQ==
X-Received: by 2002:ac8:1941:: with SMTP id g1mr9881268qtk.193.1543697554371;
        Sat, 01 Dec 2018 12:52:34 -0800 (PST)
Received: from [192.168.1.204] (pool-108-7-72-149.bstnma.fios.verizon.net. [108.7.72.149])
        by smtp.gmail.com with ESMTPSA id g23sm6214034qta.24.2018.12.01.12.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 12:52:33 -0800 (PST)
Subject: Re: block layer API for file system creation - when to use multidisk
 mode
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Ilya Dryomov <idryomov@gmail.com>,
        xfs <linux-xfs@vger.kernel.org>,
        Mark Nelson <mnelson@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <67627995-714c-5c38-a796-32b503de7d13@sandeen.net>
 <20181005232710.GH12041@dastard>
 <CAOi1vP-Z7xZk1YvWHYWQGOHfyWccFCkyn8je0HBvGhGuUrXmaQ@mail.gmail.com>
 <20181006232037.GB18095@dastard>
 <36bc3f17-e7d1-ce8b-2088-36ff5d7b1e8b@sandeen.net>
 <0290ec9f-ab2b-7c1b-faaf-409d72f99e5f@gmail.com>
 <20181129214851.GU6311@dastard>
 <39031e68-3936-b5e1-bcb6-6fdecc5988c1@gmail.com>
 <20181130022510.GW6311@dastard>
 <3da04164-a89f-f4c0-1529-eab12b3226e1@gmail.com>
 <20181201043509.GZ6311@dastard>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <80505ddf-8c6f-50d7-1e6d-2e50e7349c6f@gmail.com>
Date:   Sat, 1 Dec 2018 15:52:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181201043509.GZ6311@dastard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 11:35 PM, Dave Chinner wrote:
> On Fri, Nov 30, 2018 at 01:00:52PM -0500, Ric Wheeler wrote:
>> On 11/30/18 7:55 AM, Dave Chinner wrote:
>>> On Thu, Nov 29, 2018 at 06:53:14PM -0500, Ric Wheeler wrote:
>>>> Other file systems also need to
>>>> accommodate/probe behind the fictitious visible storage device
>>>> layer... Specifically, is there something we can add per block
>>>> device to help here? Number of independent devices
>>> That's how mkfs.xfs used to do stripe unit/stripe width calculations
>>> automatically on MD devices back in the 2000s. We got rid of that
>>> for more generaly applicable configuration information such as
>>> minimum/optimal IO sizes so we could expose equivalent alignment
>>> information from lots of different types of storage device....
>>>
>>>> or a map of
>>>> those regions?
>>> Not sure what this means or how we'd use it.
>>> Dave.
>> What I was thinking of was a way of giving up a good outline of how
>> many independent regions that are behind one "virtual" block device
>> like a ceph rbd or device mapper device. My assumption is that we
>> are trying to lay down (at least one) allocation group per region.
>>
>> What we need to optimize for includes:
>>
>>      * how many independent regions are there?
>>
>>      * what are the boundaries of those regions?
>>
>>      * optimal IO size/alignment/etc
>>
>> Some of that we have, but the current assumptions don't work well
>> for all device types.
> Oh, so essential "independent regions" of the storage device. I
> wrote this in 2008:
>
> http://xfs.org/index.php/Reliable_Detection_and_Repair_of_Metadata_Corruption#Failure_Domains
>
> This was derived from the ideas in prototype code I wrote in ~2007
> to try to optimise file layout and load distribution across linear
> concats of multi-TB RAID6 luns. Some of that work was published
> long after I left SGI:
>
> https://marc.info/?l=linux-xfs&m=123441191222714&w=2
>
> Essentially, independent regions - called "Logical
> Extension Groups", or "legs" of the filesystem - and would
> essentially be an aggregation of AGs in that region. The
> concept was that we'd move the geometry information from the
> superblock into the legs, and so we could have different AG
> geoemetry optimies for each independent leg of the filesystem.
>
> eg the SSD region could have numerous small AGs, the large,
> contiguous RAID6 part could have maximally size AGs or even make use
> of the RT allocator for free space management instead of the
> AG/btree allocator. Basically it was seen as a mechanism for getting
> rid of needing to specify block devices as command line or mount
> options.
>
> Fundamentally, though, it was based on the concept that Linux would
> eventually grow an interface for the block device/volume manager to
> tell the filesystem where the independent regions in the device
> were(*), but that's not something that has ever appeared. If you can
> provide an indepedent region map in an easy to digest format (e.g. a
> set of {offset, len, geometry} tuples), then we can obviously make
> use of it in XFS....
>
> Cheers,
>
> Dave.
>
> (*) Basically provide a linux version of the functionality Irix
> volume managers had provided filesystems since the late 80s....
>
Hi Dave,

This is exactly the kind of thing I think would be useful.  We might want to 
have a distinct value (like the rotational) that indicates this is a device with 
multiple "legs" so that normally we query that and don't have to look for the 
more complicated information.

Regards,

Ric


