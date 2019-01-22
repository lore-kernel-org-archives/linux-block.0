Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE08C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4008F217D4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pGz23cxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAVDL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:11:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVDL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 22:11:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0M39jct194967;
        Tue, 22 Jan 2019 03:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=84FyAas9GBCX5lJ93e29JK4UigMUdkoq0yvsk/iQ8Jg=;
 b=pGz23cxY9GEzMDiWD4wAsMLhBY3aTYlfbEw2Y45XLy+UNiE8cB6ht+l4pGLdPkzO9HEB
 g3bIMx5a66mz3Ve5u3Q0kuD1HmSEBOJb8i6Pk1k10fN0OEihQmnEMfssEspn6il10Ftg
 F7uqhTDo+4yGk27A6aWU1ey5wzelePMIq3NpIxraa9rMcIZxVY0Im0rftUaEGlvzyS+s
 uSTy5VoFdxWcAMzL0UH+x3iyk5vOfTQ2UeqQO0N0MsiFgMM0qJaV/gcJ1HU2eMq5lbKS
 TjRSNFRI3W6+LcGp+ZO+/PD9GxAOPBk6Wv1PgUpAiyM0zAYIx2OOqCFHiIX/o910a7HZ 3A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhrh15s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 03:11:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0M3B6VN032362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 03:11:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0M3B4QM017398;
        Tue, 22 Jan 2019 03:11:04 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 19:11:04 -0800
Subject: Re: dd hangs when reading large partitions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
Date:   Tue, 22 Jan 2019 11:12:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9143 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

On 1/21/19 11:22 PM, Marc Gonzalez wrote:
> Well, now we know for sure that the clk_scaling_lock is a red herring.
> I applied the patch below, and still the system locked up:
> 
> # dd if=/dev/sde of=/dev/null bs=1M status=progress
> 3892314112 bytes (3.9 GB, 3.6 GiB) copied, 50.0042 s, 77.8 MB/s
> 
> I can't seem to get the RCU stall warning anymore. How can I get
> to the bottom of this issue?
> 

Can you detail the system 'locked up' ?
dd hangs there ? any hung task warning log ?

hang forever or just hang for a relatively long time.

And what is the status of the dd when it hangs ?
Can you take some samples of the /proc/<dd's pid>/status and /proc/<dd's pid>/stack during the hang ?

And also would you please share the dmesg log and config ?

Since always fails with buffered read with fixed bytes,
what is the capacity of your system memory ? 


Thanks
Jianchao
