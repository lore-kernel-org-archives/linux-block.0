Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7DC433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D392339E
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbhATOul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:50:41 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:36898 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbhATOpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 09:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1611153947;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0kFn7FE/6bFw7bPBEEcHvFd4onbe7+PzHLk7jDGWBUo=;
  b=fp9AeknGl9nz3aXNLCpU/Otn17nnuQGJjoP9zSK3CG4bJ9DsrtECWCvH
   D/kk0fCljJOucX7ReSX1Zuc6NirY9NlLBHSWzq5Znox12a8R15xjZAENV
   qvOn/kg9z+RZVR8V/J/1SptdAwmEeDYKS6qq8NukYi0J3FdvxrH7CDcgz
   A=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: aolyax8z7ddkC2NBOrWWP7fk5u91dmv/GiOu6ZpP4vSQNuMLY0RGvseSTUga6C7OWKsKrK+pqZ
 Tq0BmXosM0HgA976gdLnH5vd6D5Wg05jpxOuoFpYGgQYBoPKvxfQbF0ssgNZVNMEnY3Fhq7tHx
 qC9fwK6JtpMoXgOeEZNAqR26vNmtx9QM487Or/nFy/6lnkb0xHFwNqHJLRO/6PmJGel91iDUue
 mzXm4ylt6u/Th1970GqqlcL0vF2Ab85OnE+Zm2/3aOXkSouSU2b6N26y6GY+Ufgymbs9Orhw0a
 QAs=
X-SBRS: 5.2
X-MesageID: 35845535
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23: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
X-IronPort-AV: E=Sophos;i="5.79,361,1602561600"; 
   d="scan'208";a="35845535"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDDD/7tEGheX87KBy8mRzWM4YhNZ4Oi6zo54EeuYOjbag9Uo7eBoHn6Qsyz3YFA8VqsvyDz6URlLNjrQN2Tv9SUzoEBnfdjKd/OWZxEB7VRjDAegzYnYzgu2eU6dp6UeKg1IProfC6jiPaniYwUIf7kjgnByR44XkjVjVO7uZg2Omhkaj4t2fQsuXOBTvlMcC6zOmO7Lsfd+OzyVkw90F6CqULhh+MtNnsrPPONk0mpZDvbmfwH2UEZqfLVrXcA1EF2vmShsahpO2ytJuDf21LEYiDfcfb86osf7G8az/bXH6D1B1Wzn880FMtgH32TACilQ2Iwlw6TrFxgvBNvdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1eaplPOBbaDwYza/bZPFcOcVO9nnrVVB4KKQ/vU1yQ=;
 b=hKiypgOf42NMxH7ceCT7ksD4lJyb83Y82SQmDNksB5s1nLpEzmmKlTOKLYj2LgQ5jtz1XDyOEiWUU6AAhXKLo5FSR8HkNaBpXFg2w7jiiEPgRjdiVqkyzpgkuEDdGpxA3+T84NEEn3x54BKLQLmBtfU0acTXQNS51W6KWCZuWrk5vZuCIMRhCmIQeIHdNCX0FestNyYewXdWwdRwAJbi5BQEAtJs9QCr/6JW8WgsFNPT5xBTMIc80tcxk1upono2aSBBqTrZqCPc8/eiRxnFCWheRxOdK5csW8i4UKWUk3Y0bkKEVtD3+mss3lXLB/GJ6wLCqMjZLP+c0LLYnw+BAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1eaplPOBbaDwYza/bZPFcOcVO9nnrVVB4KKQ/vU1yQ=;
 b=Q0tWecSo3TmdBuzx30YP4pwRA8enDAQqp1JOL7aaKqcaX35NbmjO1UinMqw38CgE3HgmvBfG9eud3LsD6ygrEY+rn6/wNdQ2iGCC1e8TSgugyXh4b5ON4SLLfQ/TuvmKijq6AnqQvHdeJilVcAAI/T09FQDpygxLQfSbaU9+EWY=
Date:   Wed, 20 Jan 2021 15:44:25 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>,
        Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
Message-ID: <20210120144425.ccdkettzzr4hvwip@Air-de-Roger>
References: <20210119105727.95173-1-roger.pau@citrix.com>
 <CALUcmUkd9Eeau6tC9ZWHbLdvHTYfY34LvK6KKpOOxreYF67Myg@mail.gmail.com>
 <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger>
 <83d1aca5-2637-f1f2-3006-69fc6ba76bb4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83d1aca5-2637-f1f2-3006-69fc6ba76bb4@suse.com>
X-ClientProxiedBy: PR3P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::20) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751f4859-ae12-4d7d-d419-08d8bd51e4c8
X-MS-TrafficTypeDiagnostic: DM5PR03MB3212:
X-Microsoft-Antispam-PRVS: <DM5PR03MB321282D540E172998EB6AC018FA29@DM5PR03MB3212.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zq4t1b+8eWOxHdKHQU12yJ3pwDyFG2C9Y0rlRt4mRc8AUxXL9ggUOOHoW8axOKlsVw2i+Xi5FlNGG60L+pzhZomiob3H9UD2kYkIESLhCWSl2n+oF50Iue1GHz7dRMiFJhIdkAP/wxB9g/740NuUUT++j/nLph72PwVG/NXXJwfSvatCt+RfSEH6Fz1xOktEUy4+xzIpicXDGOijU83dcXCZBDRzJPMAsxlbstpTtPLCfNPUIVf4jma/17Yi5e4lETb/RN2Ozw4wDind/ypgbn+dGSYRz6UQ+Tn3HnnKmzjaJyfcEOBZosIpAUm39RSYVJurd6FMJi4+GmpfaV9ygpsApRTRrJNE3w3ZMZxjYaZ5Wz1ojfXJU0+H+XbaVTdWzCjiXYjBnZIUHA6YhvrQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(956004)(6666004)(83380400001)(478600001)(33716001)(4326008)(26005)(1076003)(85182001)(16526019)(53546011)(8676002)(5660300002)(86362001)(9686003)(8936002)(6486002)(54906003)(186003)(2906002)(6496006)(316002)(66946007)(66476007)(7416002)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SVVWYjFObk96cjl4NmRyNXJpQWRmODRqUUNsWDRieEIxUDJxNGVnUTh1RFdM?=
 =?utf-8?B?TElKd1BMeG1EZUZtWkdYSDgwS1Q0eUZMK2M5S3RxeXdWdXU1eGl2bFVOcU9F?=
 =?utf-8?B?OWo1K0pkRFpSYkZsamVOVU0wRVFPNU1ERFZEYTdVN3FmVENaemhOR2JWNzdr?=
 =?utf-8?B?ZmNZRElrK1crZ1hUVkVpL09QRmRSemxMWFhQVG1LZW9xbGJZUW9oYWRRcHJq?=
 =?utf-8?B?enNGTmtpZEtHRWdYa3VUd2NHUUpxL2hZR21rczVCYWcxWTdiU2Zxd0lYYktk?=
 =?utf-8?B?TnQ2SC9HOTc0RlZmRkUyMVdkSlZtbnhVYW8vcmNjOUduTFh3eEpCakRtWVVV?=
 =?utf-8?B?WTdMN29IVWk4ZGZwQ2dFbitRRWt2dERQSWFWTlcxbFgvODJScG9yUVpubGM1?=
 =?utf-8?B?UXJUNzN2aHRRNGtFZmhpZmErQ2Zhd3dTQXIvQmF5aWRySjNJc3JVWVBkbnFC?=
 =?utf-8?B?N0htWFRBcWlPRFc1ODRmT0NYL1dieUdLbWV3UU8zYzg4WXRqVmlrU0F5Rjk3?=
 =?utf-8?B?eHdENk1uRFQ1aUVNOVl3VnRGc21IbWRSdDN3cEt0ZU1OdGhjT1NZOEdReTdR?=
 =?utf-8?B?azlCVi9sWGo0QVdyMjdsck9BbVhJeWV6cE0wU0tpN0p3ZU15UkVtRzducUVx?=
 =?utf-8?B?OFhnQUpxNVpqUFd2aldMbVc1V3hDbko0WmNoNjNqZWpSRDBtNVZhU2prOTdi?=
 =?utf-8?B?eFRpMGd6aHl5N2E2MUN2T2NGUms3RXg3dVk2YjZFNk1Zb3dUL0pBeSt6ck1H?=
 =?utf-8?B?VzFLZ05aZ3M1Y2g3bGxjaDdtbnFQdytDbTkxZTk0eTZvaXJFSERKQXF5V3pK?=
 =?utf-8?B?UlZKc3hWcXJ0bU5iYlkwdEtJdWthdThRQnNnNXdEeFVreDN1WTdRSWdhZkpm?=
 =?utf-8?B?MHkzZGR5RWRMNjc3OVlaeTlqTlVUK002dCtLdmw5dWxKeVdUNDE5T282UENV?=
 =?utf-8?B?STlxQkVyZ0ZUbW1maEJyQUV0Y3Bza3VTcGFPVjZ0TlZFUlVyclY3ckF6YmVi?=
 =?utf-8?B?bUlyRko4OFZIckVTakZZN2VhV0E5enMrRjdoL2lHNWF2V2NEaWtOem41MkEz?=
 =?utf-8?B?eVlKMWxCaklXSUNEV1R2c2FWRXRFaWlKYWJsNkJOa3hFT2RHMFdIbHhaaWJv?=
 =?utf-8?B?RndJZUlVRmRpUjQwa1liNDdLQ0hGTWU3Qk9UTE95QXMxQms5Vnpad3JrdlQv?=
 =?utf-8?B?R0hXalFKTXowNFUrQnhlWE0rbDNwbzh6UUw3Q1dUYmRzbEpyanBRV1Y1RHU3?=
 =?utf-8?B?VmVkK2VDczRXbGZOcmZadE4yNVFkLzY4bFYraGwwU1kvZ0c3L1Bra09GZ3N6?=
 =?utf-8?Q?oinZZHzSdeSYmQgDhkMMCUHP3m/ga84rvh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f4859-ae12-4d7d-d419-08d8bd51e4c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 14:44:30.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKc3HN3AsmEPuKBpDDpSwgpCM/3gMcP3XLgluvlh46qJsZ0F+MpHHdd5Op0e/Tqt19RK4zj1fevBEvgM7HP2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3212
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 20, 2021 at 03:37:57PM +0100, Jan Beulich wrote:
> On 20.01.2021 15:35, Roger Pau Monné wrote:
> > On Wed, Jan 20, 2021 at 03:23:30PM +0100, Arthur Borsboom wrote:
> >> Hi Roger,
> >>
> >> I have set up a test environment based on Linux 5.11.0-rc4.
> >> The patch did not apply clean, so I copied/pasted the patch manually.
> >>
> >> Without the patch the call trace (as reported) is visible in dmesg.
> >> With the patch the call trace in dmesg is gone, but ... (there is always a
> >> but) ...
> >>
> >> Now the discard action returns the following.
> >>
> >> [arthur@test-arch ~]$ sudo fstrim -v /
> >> fstrim: /: the discard operation is not supported
> >>
> >> It might be correct, but of course I was hoping the Xen VM guest would pass
> >> on the discard request to the block device in the Xen VM host, which is a
> >> disk partition.
> >> Any suggestions?
> > 
> > Hm, that's not what I did see on my testing, the operation worked OK,
> > and that's what I would expect to happen in your case also, since I
> > know the xenstore keys.
> 
> Does discard work on partitions (and not just on entire disks)?
> It's been a while since I last had anything to do with this code,
> so I may well misremember.

The command provided did work for me, ie:

# fstrim -v /
/: 19.8 GiB (21190717440 bytes) trimmed

AFAICT the blkif discard interface we provide operates at physical
block granularity, so it's possible to discard a single block, and
hence should work against partitions.

Roger.
