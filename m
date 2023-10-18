Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB6CDB484
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 18:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJRS4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRS4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 14:56:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E1118
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 11:56:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-357ac7cd08aso53955ab.1
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697655363; x=1698260163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVG/DlHpdZZH+KSMQU+OmxEYCyq6fIv9GNU3RDjJ/Zo=;
        b=Dkpeia/QUHmtfCNi+ysfl3EDl26DMSDmWeWDoBIYzOcoPL5FWAkLxYpyyLwXcZOIrT
         QXvKEqxWFpl/aUoh23pAzTSwTaaTb7RRH7Qtg8oB6ZMNNmBtAZTEPPbkcgVJ7RM1xjRa
         vGgyG8nvNvVXdHeNTX5nP8kwXfOAUnL/jP5ikcv6VYGlr7Z1rz7h04U6ZYt/3DauotSk
         owATp1LdmhtBNC1zEcuj8h05n6+eSmUG/iurGQQzRw/CqeNRtGlpZVljetJ2vu55X0r9
         +dQiiyYSAtMd74hLYMiKwWfpB2evRLNyJ6FceAb9uegUdJNGd5FIeszFkhq/BUlxEPt+
         Hofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655363; x=1698260163;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVG/DlHpdZZH+KSMQU+OmxEYCyq6fIv9GNU3RDjJ/Zo=;
        b=uyeqh3rjXfpGr74zFsm52TiRW0cLPm4JQCUQdJVbdcWhojAm9gRDfiTruqOP8ZVgrZ
         O3p/SVkdWckaVYY5JyfPf5RtkYNf0uFmC9nyvP24THAO5ecZmfnOdcazfvC5vQ8D32wC
         4P0VmTJhBHOF1x4PHWb8FnQbbjCIVhXERovyEprrRCeAkEdOvXccVtpoOvT5tkQO93FW
         iCoFncHddC+gAamofj5hFHbxwm5MnBXEnoaDDeWFVF3/QlbDyCJvBjQxvdpy1lYiqh1r
         ooOSk9n9h5ouXgZW/9ForODqg/ik8yXNl+WZYNFlhmrkPRSn63+bPn3FL9JLXb5Q2H0w
         AVpQ==
X-Gm-Message-State: AOJu0Ywv3NqXUfYwEl58W+3n0HdncTnMCITNmRy5o0hWb7zk4yPH8ApA
        cv2+YfmzLa3AH6Lk6Feud/vjTQ==
X-Google-Smtp-Source: AGHT+IGerNLbfKwO/oOTdJlHjLegab5hpjkC96PVUOOXxToRZ1K6Cv/dY6F1hr25FA4tM5soDmcbLw==
X-Received: by 2002:a6b:e713:0:b0:79f:8cd3:fd0e with SMTP id b19-20020a6be713000000b0079f8cd3fd0emr123870ioh.1.1697655363056;
        Wed, 18 Oct 2023 11:56:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ed10-20020a056638290a00b0042b09bde126sm1360195jab.165.2023.10.18.11.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:56:02 -0700 (PDT)
Message-ID: <eed61ec8-607c-46e2-ac3b-9121ba64c376@kernel.dk>
Date:   Wed, 18 Oct 2023 12:56:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Content-Language: en-US
To:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
 <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <8f239910-af73-4363-abca-d35c5d6d3216@kernel.dk>
 <CO1PR10MB4563F2D918EF5BBAD98FC87098D5A@CO1PR10MB4563.namprd10.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO1PR10MB4563F2D918EF5BBAD98FC87098D5A@CO1PR10MB4563.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please fix your quoting, it's impossible to have coherent threads
otherwise. This is the third time I'm bringing that up, but it's just
being ignored. Not the best way to have a fruitful discussion on how
best to fix this.

-- 
Jens Axboe

