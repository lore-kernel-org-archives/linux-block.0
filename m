Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25151C282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B72084E
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfBLP1F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:27:05 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48425 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfBLP1E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 10:27:04 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 45D1F13F8C0;
        Tue, 12 Feb 2019 16:26:10 +0100 (CET)
Subject: [SOLVED] dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        James Bottomley <jejb@linux.ibm.com>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
 <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
 <0cfe1ed2-41e1-66a4-8d98-ebc0d9645d21@free.fr>
 <d91e8342-4672-d51d-1bde-74e910e5a959@free.fr>
 <27165898-88c3-ab42-c6c9-dd52bf0a41c8@free.fr>
 <66419195-594c-aa83-c19d-f091ad3b296d@free.fr>
 <1549640986.34241.78.camel@acm.org>
 <690af800-1cd2-3e68-94d9-bc4825790837@free.fr>
 <493e04e4-849d-8f25-95e3-408f775fab64@free.fr>
Message-ID: <734274cc-d22b-5fe9-1650-b13c692c5b9d@free.fr>
Date:   Tue, 12 Feb 2019 16:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <493e04e4-849d-8f25-95e3-408f775fab64@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/02/2019 18:27, Marc Gonzalez wrote:

> A colleague pointed out that some memory areas are reserved downstream.
> Perhaps the FW goes haywire once the kernel touches reserved memory?

Bingo! FW quirk.

https://patchwork.kernel.org/patch/10808173/

Once the reserved memory range is extended, I am finally able
to read large partitions:

# dd if=/dev/sda of=/dev/null bs=1M
55256+0 records in
55256+0 records out
57940115456 bytes (58 GB, 54 GiB) copied, 786.165 s, 73.7 MB/s

Thanks to everyone who provided suggestions and guidance.

Regards.
