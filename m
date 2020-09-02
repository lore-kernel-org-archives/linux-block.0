Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F68C433E6
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C62084C
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 08:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Ei7Bzzox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBIEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 04:04:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4161C061244
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 01:04:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a17so4178522wrn.6
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ITan/zWSkbnHfpsc035XWViobYfAo1iIHcwyiV6vkj4=;
        b=Ei7BzzoxqD3QGipbXt1TuGH/beBPbo1RAf16/0vRAsw/iy+rXNLeISy72B+5AEtnpu
         zBNjabWW79SX5ZhUBPwQ8ykTA1sO4KEt17z8lhruVcHxlLYttBqZ/4jf33/tY30WShY1
         A/LAVnjntmc+pKn4HK0tMTtNxZN4MzL8g9bdWcqpUV18YSgZ47eGmFSRzMsQgDKVT6be
         ZMfGK5yozLBTj4+wbyfWou5pVSPWYuqvCIrZuWh3Pdoo0GRlCSezl3rmImcJsULSOdkI
         0SoWVrGywta4MUPG7ffDnHJ1xgrCWvZwFBnCVV0LfSHPuNXPkXtIDYgcnj6yTDS9Kqsb
         BnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ITan/zWSkbnHfpsc035XWViobYfAo1iIHcwyiV6vkj4=;
        b=gSHVPsFoqjO40mX48djpEhatIYvjiWdGUHNN/ouS9wls3yFIfG70XfareVBThX50ev
         bIW3PtW77fBSruR8wmqdoRVxptcOtHgEScrrsGVIqsHlCUYy5CdnxDSALqw39zHYcNiN
         WxlXgKeaJGRI0aqDKRD/p7Ob9tea4Tr11lM1uUsHK8Hj/geBYSl8FfLlKiUjazdJm8rp
         n3MHcyLLujpo0YG8rP6igfjsKXTfcI71Ilk4FMpwGRQTogh+6KE22l+GFYrDJTzZO794
         EyOjnmhHdx1jejs+7BlzuX9topFIMS0LGBTRkfZtENnVmG1z5zNcif0YfKey7HizXqzh
         UDSA==
X-Gm-Message-State: AOAM530pg0JYcmT3frRJ2DDVZg6v9OjZ/WEohzh0iQJH2hOGa7/92Tht
        wL2RHKtsRP5TJm2QR5aGEOGKmQRTZeEDpWmftByA
X-Google-Smtp-Source: ABdhPJwjmZyPbIbsIS0onIVB4/6WhNp5Hwjzy8zBBzVuPFznPgphMCKLBbkBEU9IhwXmGLh7hyv56e86QYxlsUzSGrg=
X-Received: by 2002:adf:de08:: with SMTP id b8mr5595440wrm.4.1599033881354;
 Wed, 02 Sep 2020 01:04:41 -0700 (PDT)
MIME-Version: 1.0
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 2 Sep 2020 10:04:30 +0200
Message-ID: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
Subject: [RFC] Reliable Multicast on top of RTRS
To:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi @,

RTRS allows for reliable transmission of sg lists between two hosts
over rdma. It is optimised for block io. One can implement a client
and a server module on top of RTRS which would allow for reliable
transmission to a group of hosts.

In the networking world this is called reliable multicast. I think one
can say that reliable multicast is an equivalent to what is called
"mirror" in the storage world. There is something called XoR network
coding which seems to be an equivalent of raid5. There is also Reed
Solomon network coding.

Having a reliable multicast with coding rdma-based transport layer
would allow for very flexible and scalable designs of distributed
replication solutions based on different in-kernel transport, block
and replication drivers.

What do you think?

Best,
Danil.
