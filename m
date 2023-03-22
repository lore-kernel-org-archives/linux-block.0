Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B2DC6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 07:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCVHbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVHbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 03:31:17 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AAB567A6
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:31:15 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id m2so15984846wrh.6
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470274; x=1682062274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcfLk8cw/2p3N7aKlNuwPG0cuKZ2Kw10diUrp1mnJ3A=;
        b=5rGOvu4aQcWaADgiJNFxc+BkDMJskXznQRBE8vDsIquChkP9u/ZLfk8rdZ9BS/EQjf
         KMopOA4h6LdcupT7D5uf4Z/riwRkckqePvIlS0Qi1P9K6rGiaNU0NBeW0FkuUiWJKbks
         qzi3A7Bce4FYcdDe7TdulEdQdiCA6Ok9WBcfzG3lezJmLwmAD8pqIqWOt78iC0LtDNTT
         em1dSB/i6YqpfRwxUe7wUgXCpZLvuD4nOOAv+FANEjcJ8BLedv8TNG1g0T2xcXixBYjb
         5HzNdHMTb9z+/uWcfPtoosTjauVe222nWnD9D2PinGAt36PEtsUpf8KhtRIu0dIqFejy
         0W7g==
X-Gm-Message-State: AO0yUKV+d094WKb8Uqkj9h7qKrAyagq4q4pmaN0mvvbgyNl/qVj3KZW/
        k9jIWw4VWIMz/TjBanweCiY=
X-Google-Smtp-Source: AK7set+UxuK17yFX20aI+9ixMZkvP5foOFbMreNQHsccPEXU7hXbaXhY2lk9uMH0xu13yIbqCj2q8A==
X-Received: by 2002:adf:dbc8:0:b0:2c7:d80:ffc4 with SMTP id e8-20020adfdbc8000000b002c70d80ffc4mr3249320wrj.7.1679470274416;
        Wed, 22 Mar 2023 00:31:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm13303951wrr.79.2023.03.22.00.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:31:14 -0700 (PDT)
Message-ID: <2027b975-1c9e-eb92-e374-9719bad49869@grimberg.me>
Date:   Wed, 22 Mar 2023 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] nvme fabrics polling fixes
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I couldn't test the existing tcp

It is very simple to do, for tcp you can just operate on the loopback
iface 127.0.0.1

See example:
$ ./target.sh 1 1
$ nvme connect-all -t tcp -a 127.0.0.1 -P 1

For rdma you can work on any interface you want, you just need
iproute with rdma utility (which is available with recent iproute
packages).

Setup Software RoCE:
$ rdma link add rxe0 type rxe netdev <iface>
Setup Software iWarp:
$ rdma link add siw0 type siw netdev <iface>

Then the same as before...
$ ./target.sh 1 1
$ nvme connect-all -t tcp -a <iface-addr> -P 1


That is essentially what blktest do.

target.sh
--
#!/bin/bash

# args: <num_subsys> <nr_ns-per-subsystem> <nvme|file>
# examples:
# - ./target.sh 1 1       # uses null_blk
# - ./target.sh 1 1 nvme
# - ./target.sh 1 1 file

CFGFS=/sys/kernel/config/nvmet
NQN=testnqn

mount -t configfs configfs /sys/kernel/config > /dev/null 2>&1

rm -f $CFGFS/ports/*/subsystems/*
rm -f $CFGFS/subsystems/*/allowed_hosts/* > /dev/null 2>&1
rmdir $CFGFS/subsystems/*/namespaces/* > /dev/null 2>&1
rmdir $CFGFS/subsystems/* > /dev/null 2>&1
rmdir $CFGFS/ports/* > /dev/null 2>&1
rmdir $CFGFS/hosts/* > /dev/null 2>&1

modprobe -r nvmet_rdma nvmet-tcp > /dev/null 2>&1
modprobe -r ib_umad rdma_ucm ib_uverbs rdma_cm > /dev/null 2>&1

modprobe -r null_blk nvme-tcp nvme-rdma
modprobe -r nvme-loop
rm -f /tmp/nsf*

if [[ $1 == "0" ]]; then
         exit
fi

modprobe null_blk nr_devices=$2 #queue_mode=0 irqmode=0
modprobe -a nvmet_tcp nvmet_rdma

mkdir $CFGFS/ports/1
echo 0.0.0.0 > $CFGFS/ports/1/addr_traddr
echo 8009 > $CFGFS/ports/1/addr_trsvcid
echo "tcp" >  $CFGFS/ports/1/addr_trtype
echo "ipv4" >  $CFGFS/ports/1/addr_adrfam

mkdir $CFGFS/ports/2
echo 0.0.0.0 > $CFGFS/ports/2/addr_traddr
echo 4420 > $CFGFS/ports/2/addr_trsvcid
echo "rdma" >  $CFGFS/ports/2/addr_trtype
echo "ipv4" >  $CFGFS/ports/2/addr_adrfam

mkdir $CFGFS/ports/3
echo "loop" >  $CFGFS/ports/3/addr_trtype

for j in `seq $1`
do
         mkdir $CFGFS/subsystems/$NQN$j
         echo 1 > $CFGFS/subsystems/$NQN$j/attr_allow_any_host
         k=0
         for i in `seq $2`
         do
                 mkdir $CFGFS/subsystems/$NQN$j/namespaces/$i
                 if [[ "$3" == "nvme" ]]; then
                         echo -n "/dev/nvme0n1" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 elif [[ "$3" == "file" ]]; then
                         ns="/tmp/nsf$k"
                         touch $ns
                         truncate --size=2G $ns
                         echo -n "$ns" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 else
                         echo -n "/dev/nullb$k" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 fi
                 echo 1 > $CFGFS/subsystems/$NQN$j/namespaces/$i/enable
                 let "k+=1"
         done
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/1/subsystems/
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/2/subsystems/
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/3/subsystems/
done
--
