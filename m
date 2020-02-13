Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7124FC352A3
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5469E246CA
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgBMUTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:19:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:15839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgBMUTo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 15:19:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 12:19:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="227363660"
Received: from vkarunag-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.232.115.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2020 12:19:43 -0800
Subject: Re: [PATCH v2 2/2] md: enable io polling
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
 <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
 <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <f516e2b2-1988-03ca-f966-5f26771717ff@linux.intel.com>
Date:   Thu, 13 Feb 2020 13:19:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/20 2:42 PM, Keith Busch wrote:
> On Wed, Feb 12, 2020 at 02:00:10PM -0700, Andrzej Jakowski wrote:
>> On 2/11/20 2:13 PM, Keith Busch wrote:
>>> I must be missing something: md's make_request_fn always returns
>>> BLK_QC_T_NONE for the cookie, and that couldn't get past blk_poll's
>>> blk_qc_t_valid(cookie) check. How does the initial blk_poll() caller get
>>> a valid cookie for an md backing device's request_queue? And how is the
>>> same cookie valid for more than one request_queue?
>> That's true md_make_request() always returns BLK_QC_T_NONE. md_make_request()
>> recursively calls generic_make_request() for the underlying device (e.g. nvme).
>> That block io request directed to member disk is added into bio_list and is 
>> processed later by top level generic_make_request(). generic_make_request() 
>> returns cookie that is returned by blk_mq_make_request().
>> That cookie is later used to poll for completion. 
> Okay, that's a nice subtlety. But it means the original caller gets the
> cookie from the last submission in the chain. If md recieves a single
> request that has to be split among more than one member disk, the cookie
> you're using to control the polling is valid only for one of the
> request_queue's and may break others.

Correct, I agree that it is an issue. I can see at least two ways how to solve it:
 1. Provide a mechanism in md accounting for outstanding IOs, storing cookie information 
    for them. md_poll() will then use valid cookie's
 2. Provide similar mechanism abstracted for stackable block devices and block layer could
    handle completions for subordinate bios in an abstracted way in blk_poll() routine.
How do you Guys see this going?
